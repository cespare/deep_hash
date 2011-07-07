require "deep_hash/version"

class Hash
  def self.deep(depth = nil, &block)
    raise "Need a number for depth" unless depth.nil? || depth.respond_to?(:to_i)
    if depth.nil?
      raise "Cannot use a block with nil depth." if block_given?
      return Hash.new { |k, v| k[v] = Hash.deep(nil) }
    end
    depth = depth.to_i
    raise "Need non-negative depth" if depth < 0
    return block_given? ? Hash.new { |k, v| k[v] = block.call } : {} if depth.zero?
    Hash.new { |k, v| k[v] = Hash.deep(depth - 1, &block) }
  end
end
