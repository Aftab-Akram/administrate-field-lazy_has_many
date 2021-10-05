require 'test_helper'

module Administrate
  module Field
    class LazyHasManyTest < Minitest::Test
      def test_that_it_has_a_version_number
        refute_nil Administrate::Field::LazyHasMany::VERSION
      end

      def test_has_the_correct_partial
        %i[show index form].each do |page|
          field = Administrate::Field::LazyHasMany.new(:association, nil, page)
          partial_path = field.to_partial_path

          assert_equal "/fields/lazy_has_many/#{page}", partial_path
        end
      end
    end
  end
end
