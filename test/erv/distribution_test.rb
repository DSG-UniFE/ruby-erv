describe ERV::Distribution do
  with 'when explicitly given an RNG' do
    it 'should use the given RNG' do
      rng = Random.new
      d = ERV::Distribution.new(rng: rng)
      expect(d.instance_variable_get(:@rng)).to be == rng
    end
  end
end
