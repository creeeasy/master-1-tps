import hashlib

def blake2s(data):
    """
    Implémentation de la fonction de hachage BLAKE2s qui génère une valeur de 256 bits.
    """
    h = hashlib.blake2s(digest_size=32) 
    if isinstance(data, str):
        data = data.encode('utf-8')
    h.update(data)
    return h.digest()