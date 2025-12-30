describe ERV::SequentialRandomVariable do

  it 'should require the :first_value parameter' do
    expect{ ERV::SequentialRandomVariable.new }.to raise_exception(ArgumentError)
  end

  it 'should consider starting value' do
    first = 1.0
    srv = ERV::SequentialRandomVariable.new(first_value: first, distribution: :exponential, args: { rate: 2.0 })
    expect(srv.next).to (be > first)
  end

  it 'should consider previous sample' do
    first = 1.0
    srv = ERV::SequentialRandomVariable.new(first_value: first, distribution: :exponential, args: { rate: 2.0 })
    previous_sample = srv.next
    10.times do
      new_sample = srv.next
      expect(new_sample).to (be > previous_sample)
      previous_sample = new_sample
    end
  end

end
