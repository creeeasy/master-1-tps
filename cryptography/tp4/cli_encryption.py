import argparse
import os
from file_encryptor import FileEncryptor

def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest='command')

    encrypt_parser = subparsers.add_parser('encrypt')
    encrypt_parser.add_argument('input')
    encrypt_parser.add_argument('output')
    encrypt_parser.add_argument('password')
    encrypt_parser.add_argument('--mode', choices=['cbc', 'ctr'], default='cbc')

    decrypt_parser = subparsers.add_parser('decrypt')
    decrypt_parser.add_argument('input')
    decrypt_parser.add_argument('output')
    decrypt_parser.add_argument('password')

    args = parser.parse_args()
    encryptor = FileEncryptor()

    if args.command == 'encrypt':
        mode = encryptor.MODE_CBC if args.mode == 'cbc' else encryptor.MODE_CTR

        try:
            if not os.path.exists(args.input):
                print(f"Error: Input file '{args.input}' does not exist")
                return

            success = encryptor.encrypt_file(args.input, args.output, args.password, mode)
            if success:
                print(f"File successfully encrypted to {args.output}")
            else:
                print(f"Encryption failed")
        except Exception as e:
            print(f"Error during encryption: {str(e)}")

    elif args.command == 'decrypt':
        try:
            if not os.path.exists(args.input):
                print(f"Error: Input file '{args.input}' does not exist")
                return

            success = encryptor.decrypt_file(args.input, args.output, args.password)
            if success:
                print(f"File successfully decrypted to {args.output}")
            else:
                print(f"Decryption failed. Either the file is corrupted or the password is incorrect.")
        except Exception as e:
            print(f"Error during decryption: {str(e)}")
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
