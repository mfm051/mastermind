class Coder
  def initialize
    @code = random_code
  end

  private

  def random_code
    Array.new(4).map{ ('A'..'H').to_a.sample }
  end
end
