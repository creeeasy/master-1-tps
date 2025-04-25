import os
import struct
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from blake2s_hash import blake2s
from hmac_blake2 import hmac_blake2

class FileEncryptor:
    def __init__(self):
        self.MODE_CBC = 1
        self.MODE_CTR = 2

    def derive_key(self, password):
        if isinstance(password, str):
            password = password.encode('utf-8')
        return blake2s(password)
    
    def encrypt_file(self, input_file, output_file, password, mode):
        key = self.derive_key(password)
        iv = os.urandom(16)

        with open(input_file, 'rb') as f:
            plaintext = f.read()

        if mode == self.MODE_CBC:
            cipher = AES.new(key, AES.MODE_CBC, iv)
            padded_plaintext = pad(plaintext, AES.block_size)
            ciphertext = cipher.encrypt(padded_plaintext)
        elif mode == self.MODE_CTR:
            cipher = AES.new(key, AES.MODE_CTR, nonce=iv[:8], initial_value=int.from_bytes(iv[8:], byteorder='big'))
            ciphertext = cipher.encrypt(plaintext)
        else:
            raise ValueError("Mode not supported")

        mode_bytes = struct.pack("B", mode)
        data_to_authenticate = mode_bytes + iv + ciphertext
        tag = hmac_blake2(key, data_to_authenticate)

        with open(output_file, 'wb') as f:
            f.write(mode_bytes)
            f.write(iv)
            f.write(ciphertext)
            f.write(tag)

        return True

    def decrypt_file(self, input_file, output_file, password):
        key = self.derive_key(password)

        with open(input_file, 'rb') as f:
            file_data = f.read()

        mode = file_data[0]
        iv = file_data[1:17]
        ciphertext = file_data[17:-32]
        stored_tag = file_data[-32:]

        data_to_authenticate = file_data[:-32]
        calculated_tag = hmac_blake2(key, data_to_authenticate)

        if calculated_tag != stored_tag:
            return False

        try:
            if mode == self.MODE_CBC:
                cipher = AES.new(key, AES.MODE_CBC, iv)
                plaintext = unpad(cipher.decrypt(ciphertext), AES.block_size)
            elif mode == self.MODE_CTR:
                cipher = AES.new(key, AES.MODE_CTR, nonce=iv[:8], initial_value=int.from_bytes(iv[8:], byteorder='big'))
                plaintext = cipher.decrypt(ciphertext)
            else:
                return False

            with open(output_file, 'wb') as f:
                f.write(plaintext)

            return True

        except Exception as e:
            print(f"Decryption error: {str(e)}")
            return False
