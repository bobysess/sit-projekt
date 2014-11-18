class  Crypt
   require "digest"
   require "opensssl"

  @iv ="\xB0\n!\xEE!\x81a\va\xD4\xCF\xA9\x19\xEB\xE3\x1A"

  def self.aes_encrypt( key, data)

    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key =
    cipher.iv = @iv

    encrypted = cipher.update(data) + cipher.final
    return encrypted;
  end

  def self.aes_decrypt(key, data)
    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = key
    decipher.iv = @iv

    plain = decipher.update(encrypted) + decipher.final

    return  plain

  end

  def  self.hash(data)
    hash= Digest::SHA256.digest  data
    return  hash
  end


end