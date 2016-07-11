require 'fileutils'

class Fvs

  @@file_name = ''
  @@bulk_insert_data = {}
  @@bulk_data = false

  class << self
    # ファイルをメモリ上に読み込んでメモリ上で操作し、ブロック操作が完了したらファイルアウトする
    def bulk
      @@bulk_insert_data = eval File.read(@@file_name)
      @@bulk_data = true
      yield
      @@bulk_data = false
      @result = File.write(@@file_name, @@bulk_insert_data)
      @@bulk_insert_data = {}
      @result
    end
  end

  def initialize(file_name = "./tmp/local.fvs")
    @@file_name = file_name
    @@bulk_insert_data = Hash.new
    File.write(@@file_name, '{}') unless File.exist?(@@file_name)
  end

  def create(key, value)
    if @@bulk_data
      @@bulk_insert_data[key] = value
    else
      hash_data = eval File.read(@@file_name)
      hash_data[key] = value
      File.write(@@file_name, hash_data)
    end
  end

  def find(key)
    if @@bulk_data
      @@bulk_insert_data[key]
    else
      hash_data = eval File.read(@@file_name)
      hash_data[key]
    end
  end

  def update(key, value)
    if @@bulk_data
      @@bulk_insert_data[key] = value
    else
      hash_data = eval File.read(@@file_name)
      hash_data[key] = value
      File.write(@@file_name, hash_data)
    end
  end

  def destroy(key)
    if @@bulk_data
      @@bulk_insert_data.delete(key)
    else
      hash_data = eval File.read(@@file_name)
      hash_data.delete(key)
      File.write(@@file_name, hash_data)
    end
  end

  def findAll()
    if @@bulk_data
      @@bulk_insert_data
    else
      eval File.read(@@file_name)
    end
  end

  def destroyAll()
    if @@bulk_data
      @@bulk_insert_data = {}
    else
      File.write(@@file_name, '{}')
    end
  end

end
