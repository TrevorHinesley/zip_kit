class ZipTricks::FileReader::StoredReader
  def initialize(from_io, compressed_data_size)
    @io = from_io
    @compressed_data_size = compressed_data_size
    @already_read = 0
  end

  def extract(n_bytes=nil)
    n_bytes ||= (@compressed_data_size - @already_read)

    return if eof?

    available = @compressed_data_size - @already_read

    return if available.zero?

    n_bytes = available if n_bytes > available

    return '' if n_bytes.zero?

    compressed_chunk = @io.read(n_bytes)

    return if compressed_chunk.nil?

    @already_read += compressed_chunk.bytesize
    compressed_chunk
  end

  def eof?
    @already_read >= @compressed_data_size
  end
end
