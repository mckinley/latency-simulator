require "test_helper"

class BlimpTest < ActiveSupport::TestCase
  self.use_transactional_tests = false

  test "latency" do
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    time = Benchmark.measure {
      Blimp.uncached do
        blimp_1 = Blimp.find 1
        blimp_2 = Blimp.find 2
        blimp_3 = Blimp.count
        # blimp_4 = Blimp.slow_query
        # blimp_5 = Blimp.slow_query
        # blimp_6 = Blimp.slow_query
        blimp_4 = Blimp.slow_query.load_async
        blimp_5 = Blimp.slow_query.load_async
        blimp_6 = Blimp.slow_query.load_async

        blimp_4.to_a
        blimp_5.to_a
        blimp_6.to_a
      end
    }

    pp time.real

    assert true
  end
end
