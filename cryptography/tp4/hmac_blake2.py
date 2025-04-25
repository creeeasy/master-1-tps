from blake2s_hash import blake2s

def hmac_blake2(key, message):
    """
    Implémentation de HMAC utilisant BLAKE2s comme fonction de hachage.
    """
    if isinstance(key, str):
        key = key.encode('utf-8')
    if isinstance(message, str):
        message = message.encode('utf-8')
    
    ipad = bytes([0x36] * 64) 
    opad = bytes([0x5c] * 64)
    
    if len(key) > 64:
        key = blake2s(key)
    
    key = key.ljust(64, b'\0')
    key_ipad = bytes([k ^ i for k, i in zip(key, ipad)])
    
    inner_hash = blake2s(key_ipad + message)
    
    key_opad = bytes([k ^ o for k, o in zip(key, opad)])
    
    outer_hash = blake2s(key_opad + inner_hash)
    
    return outer_hash