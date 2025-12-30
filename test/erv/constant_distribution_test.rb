describe ERV::ConstantDistribution do
  it 'should require a reference value' do
    expect { ERV::ConstantDistribution.new }.to raise_exception(ArgumentError)
  end

  with 'reference value' do
    it 'should be accepted at initialization time' do
      expect { ERV::ConstantDistribution.new(value: 10) }.not.to raise_exception(ArgumentError)
    end

    it 'should match the value returned by sampling' do
      val = rand(100)
      crv = ERV::ConstantDistribution.new(value: val)
      expect(crv.sample).to be == val
    end
  end
end
