module ApplicationHelper
  require "aes"



  def aes_encrypt( key, data)
    iv = get_iv
    encrypted = AES.encrypt(data, key, {:iv => iv})

    return encrypted.split('$').last;
  end

  def aes_decrypt(key, data_in)
    iv = get_iv
    data=get_iv << '$'<< data_in
    plain = AES.decrypt(data, key, {:iv => iv})
    return  plain

  end

  def aes_pain_encrypt(key, data)
    iv = get_iv_2
    encrypted = AES.encrypt(data, key, {:iv => iv,:format => :plain})

    return encrypted.last;

  end

  def aes_pain_decrypt(key, data_in)
    iv = get_iv_2
    data=[]
    data<<get_iv_2
    data<<data_in
    plain = AES.decrypt(data, key, {:iv => iv,:format => :plain,:padding=>false})
    return  plain
  end



  def  hash(data)
    hash= Digest::SHA256.base64digest data
    return  hash
  end

  def current_user
     User.find(session[:user_id]) unless session[:user_id].nil?
  end

  def  get_super_key
     session[:super_key]
  end

  def  get_iv
    iv ="I0LnWpqUNcGtcZrdH73RDQ=="
  end

  def  get_iv_2
    iv=";\202\222\306\376<\206\343\023\245\312\225\214KAm"
  end

  def  generate_key
     return AES.key
  end

  def  generate_key_pair
    rsa_key = OpenSSL::PKey::RSA.new(2048)
    key_pair={}
    key_pair[:private_key]=rsa_key.to_pem
    key_pair[:public_key]=rsa_key.public_key.to_pem
    key_pair
  end

  def rsa_encrypt(key_public, data)
    public_key = OpenSSL::PKey::RSA.new(key_public)
    encrypted_data = Base64.encode64(public_key.public_encrypt(data))
    encrypted_data
  end

  def rsa_decrypt(key_private, data)
    private_key = OpenSSL::PKey::RSA.new(key_private)
    decrypted_data = private_key.private_decrypt(Base64.decode64(data))
    decrypted_data

  end

  def get_private_key
     private_key =aes_decrypt(get_super_key,current_user.key_private)
  end
end
