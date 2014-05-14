require 'test_helper'

describe ERV::SequentialRandomVariable do

  it 'should require the :first_value parameter' do
    lambda do
      ERV::SequentialRandomVariable.new
    end.must_raise ArgumentError
  end

  it 'should consider starting value' do
    first = 1.0
    srv = ERV::SequentialRandomVariable.new(first_value: first, distribution: :exponential, mean: 2.0)
    srv.next.must_be :>, first
  end

  it 'should consider previous sample' do
    first = 1.0
    srv = ERV::SequentialRandomVariable.new(first_value: first, distribution: :exponential, mean: 2.0)
    previous_sample = srv.next
    10.times do
      new_sample = srv.next
      new_sample.must_be :>, previous_sample
      previous_sample = new_sample
    end
  end

end
