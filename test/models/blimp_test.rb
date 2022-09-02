require "test_helper"

class BlimpTest < ActiveSupport::TestCase
  self.use_transactional_tests = false

  test "load_async" do
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    time = Benchmark.measure {
      Blimp.uncached do
        blimp_1 = Blimp.slow_query.load_async
        blimp_2 = Blimp.slow_query.load_async
        blimp_3 = Blimp.slow_query.load_async

        blimp_1.to_a
        blimp_2.to_a
        blimp_3.to_a
      end
    }

    pp time.real

    assert time.real < 2
  end

  test "pipeline" do
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    time = Benchmark.measure {
      Blimp.uncached do
        # binding.pry
        p '1'
        c = Blimp.connection.instance_variable_get "@connection"
        p '2'
        c.enter_pipeline_mode
        blimp_1 = Blimp.slow_query
        blimp_2 = Blimp.slow_query
        blimp_3 = Blimp.slow_query
        p '3'
        blimp_1.to_a
        # we never make it here
        p '4'
        blimp_2.to_a
        blimp_3.to_a

        c.pipeline_sync
      end
    }

    pp time.real

    assert true
  end
end
