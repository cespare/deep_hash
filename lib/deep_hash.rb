require "deep_hash/version"

class Hash
  def self.deep(depth, &block)
    raise "Need non-negative depth" if depth < 0
    if depth.zero?
      return block_given? ? Hash.new { |k, v| k[v] = block.call } : {}
    end
    Hash.new { |k, v| k[v] = Hash.deep(depth - 1, &block) }
  end
end
