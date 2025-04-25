import os
import struct
import tkinter as tk
from tkinter import filedialog, messagebox
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from blake2s_hash import blake2s
from hmac_blake2 import hmac_blake2
from file_encryptor import FileEncryptor

class FileEncryptorGUI:
    def __init__(self, master):
        self.master = master
        self.encryptor = FileEncryptor()
        master.title("File Encryption with BLAKE2s")
        master.geometry("500x350")
        master.resizable(False, False)
        
        self.create_widgets()
        
    def create_widgets(self):
        # Create widgets
        # Frame for encryption
        encrypt_frame = tk.LabelFrame(self.master, text="Encryption", padx=10, pady=10)
        encrypt_frame.pack(fill="both", expand="yes", padx=10, pady=5)
        
        # Input file for encryption
        tk.Label(encrypt_frame, text="Input File:").grid(row=0, column=0, sticky="w")
        self.encrypt_input_path = tk.StringVar()
        tk.Entry(encrypt_frame, textvariable=self.encrypt_input_path, width=50).grid(row=0, column=1, padx=5)
        tk.Button(encrypt_frame, text="Browse", command=self.browse_encrypt_input).grid(row=0, column=2, padx=5)
        
        # Output file for encryption
        tk.Label(encrypt_frame, text="Output File:").grid(row=1, column=0, sticky="w")
        self.encrypt_output_path = tk.StringVar()
        tk.Entry(encrypt_frame, textvariable=self.encrypt_output_path, width=50).grid(row=1, column=1, padx=5)
        tk.Button(encrypt_frame, text="Browse", command=self.browse_encrypt_output).grid(row=1, column=2, padx=5)
        
        # Password for encryption
        tk.Label(encrypt_frame, text="Password:").grid(row=2, column=0, sticky="w")
        self.encrypt_password = tk.StringVar()
        tk.Entry(encrypt_frame, textvariable=self.encrypt_password, show="*", width=50).grid(row=2, column=1, padx=5)
        
        # Mode selection
        tk.Label(encrypt_frame, text="Mode:").grid(row=3, column=0, sticky="w")
        self.encrypt_mode = tk.IntVar(value=self.encryptor.MODE_CBC)
        tk.Radiobutton(encrypt_frame, text="CBC", variable=self.encrypt_mode, value=self.encryptor.MODE_CBC).grid(row=3, column=1, sticky="w")
        tk.Radiobutton(encrypt_frame, text="CTR", variable=self.encrypt_mode, value=self.encryptor.MODE_CTR).grid(row=3, column=1)
        
        # Encrypt button
        tk.Button(encrypt_frame, text="Encrypt", command=self.encrypt_file, width=20).grid(row=4, column=1, pady=10)
        
        # Frame for decryption
        decrypt_frame = tk.LabelFrame(self.master, text="Decryption", padx=10, pady=10)
        decrypt_frame.pack(fill="both", expand="yes", padx=10, pady=5)
        
        # Input file for decryption
        tk.Label(decrypt_frame, text="Input File:").grid(row=0, column=0, sticky="w")
        self.decrypt_input_path = tk.StringVar()
        tk.Entry(decrypt_frame, textvariable=self.decrypt_input_path, width=50).grid(row=0, column=1, padx=5)
        tk.Button(decrypt_frame, text="Browse", command=self.browse_decrypt_input).grid(row=0, column=2, padx=5)
        
        # Output file for decryption
        tk.Label(decrypt_frame, text="Output File:").grid(row=1, column=0, sticky="w")
        self.decrypt_output_path = tk.StringVar()
        tk.Entry(decrypt_frame, textvariable=self.decrypt_output_path, width=50).grid(row=1, column=1, padx=5)
        tk.Button(decrypt_frame, text="Browse", command=self.browse_decrypt_output).grid(row=1, column=2, padx=5)
        
        # Password for decryption
        tk.Label(decrypt_frame, text="Password:").grid(row=2, column=0, sticky="w")
        self.decrypt_password = tk.StringVar()
        tk.Entry(decrypt_frame, textvariable=self.decrypt_password, show="*", width=50).grid(row=2, column=1, padx=5)
        
        # Decrypt button
        tk.Button(decrypt_frame, text="Decrypt", command=self.decrypt_file, width=20).grid(row=3, column=1, pady=10)
    
    def browse_encrypt_input(self):
        filename = filedialog.askopenfilename(title="Select file to encrypt")
        if filename:
            self.encrypt_input_path.set(filename)
            # Auto-suggest output filename
            if not self.encrypt_output_path.get():
                self.encrypt_output_path.set(filename + ".encrypted")
    
    def browse_encrypt_output(self):
        filename = filedialog.asksaveasfilename(title="Save encrypted file as")
        if filename:
            self.encrypt_output_path.set(filename)
    
    def browse_decrypt_input(self):
        filename = filedialog.askopenfilename(title="Select file to decrypt")
        if filename:
            self.decrypt_input_path.set(filename)
            # Auto-suggest output filename
            if not self.decrypt_output_path.get() and filename.endswith(".encrypted"):
                self.decrypt_output_path.set(filename[:-10])
            elif not self.decrypt_output_path.get():
                self.decrypt_output_path.set(filename + ".decrypted")
    
    def browse_decrypt_output(self):
        filename = filedialog.asksaveasfilename(title="Save decrypted file as")
        if filename:
            self.decrypt_output_path.set(filename)
    
    def encrypt_file(self):
        input_file = self.encrypt_input_path.get()
        output_file = self.encrypt_output_path.get()
        password = self.encrypt_password.get()
        mode = self.encrypt_mode.get()
        
        if not input_file or not output_file or not password:
            messagebox.showerror("Error", "Please fill in all fields")
            return
        
        if not os.path.exists(input_file):
            messagebox.showerror("Error", "Input file does not exist")
            return
        
        try:
            success = self.encryptor.encrypt_file(input_file, output_file, password, mode)
            if success:
                messagebox.showinfo("Success", "File encrypted successfully")
            else:
                messagebox.showerror("Error", "Encryption failed")
        except Exception as e:
            messagebox.showerror("Error", f"An error occurred: {str(e)}")
    
    def decrypt_file(self):
        input_file = self.decrypt_input_path.get()
        output_file = self.decrypt_output_path.get()
        password = self.decrypt_password.get()
        
        if not input_file or not output_file or not password:
            messagebox.showerror("Error", "Please fill in all fields")
            return
        
        if not os.path.exists(input_file):
            messagebox.showerror("Error", "Input file does not exist")
            return
        
        try:
            success = self.encryptor.decrypt_file(input_file, output_file, password)
            if success:
                messagebox.showinfo("Success", "File decrypted successfully")
            else:
                messagebox.showerror("Error", "Decryption failed. Either the file is corrupted or the password is incorrect.")
        except Exception as e:
            messagebox.showerror("Error", f"An error occurred: {str(e)}")


def main():
    root = tk.Tk()
    app = FileEncryptorGUI(root)
    root.mainloop()

if __name__ == "__main__":
    main()