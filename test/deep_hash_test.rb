require "scope"
require "minitest/autorun"

require "deep_hash"

class DeepHashTest < Scope::TestCase
  def assert_expected_hash(expected, actual)
    assert expected.is_a? Hash
    assert actual.is_a? Hash
    assert_equal expected.keys.sort, actual.keys.sort
    expected.keys.each do |key|
      if expected[key].is_a? Hash
        assert_expected_hash expected[key], actual[key]
      else
        assert_equal expected[key], actual[key]
      end
    end
  end

  context "deep hash creation" do
    context "with no block" do
      should "create a plain hash with depth 0" do
        assert_expected_hash({}, Hash.deep(0))
      end

      should "should create a properly nested hash of the specified depth" do
        hash = Hash.deep(1)
        hash[0][1] = 2
        assert_equal({}, hash[1])
        assert_expected_hash({ 0 => { 1 => 2 }, 1 => {} }, hash)
      end
    end

    context "with a block given" do
      should "create a normal default-valued hash with depth 0" do
        hash = Hash.deep(0) { "foobar" }
        hash[:a] = 3
        assert_equal "foobar", hash[:b]
        assert_expected_hash({ :a => 3, :b => "foobar" }, hash)
      end

      should "properly create a mult-level default hash" do
        hash = Hash.deep(1) { "foobar" }
        hash[:a][0] = 5
        assert_equal "foobar", hash[:a][1]
        assert_equal "foobar", hash[:b][0]
        assert_expected_hash({ :a => { 0 => 5, 1 => "foobar" }, :b => { 0 => "foobar" } }, hash)
      end
    end

    context "with nil depth" do
      should "raise an error if a block is given" do
        assert_raises(RuntimeError) { Hash.deep {} }
      end

      should "create an arbitrary depth default hash" do
        hash = Hash.deep
        hash[0][0][0] = 1
        hash[0][1] = 2
        hash[1] = :bar
        assert_expected_hash({ 0 => { 0 => { 0 => 1 }, 1 => 2 }, 1 => :bar }, hash)
      end
    end
  end
end
