require 'abstract_unit'

class TestEqual < ActiveSupport::TestCase
  fixtures :departments

  include CompositePrimaryKeys::Predicates

  def test_or
    dep = Arel::Table.new(:departments)

    predicates = Array.new

    5.times do |i|
      predicates << dep[:id].eq(i)
    end

    pred = cpk_or_predicate(predicates)
    assert_equal('"departments"."id" = 0 OR "departments"."id" = 1 OR "departments"."id" = 2 OR "departments"."id" = 3 OR "departments"."id" = 4',
                 pred)
  end

  def test_and
    dep = Arel::Table.new(:departments)

    predicates = Array.new

    5.times do |i|
      predicates << dep[:id].eq(i)
    end

    pred = cpk_and_predicate(predicates)
    assert_equal('"departments"."id" = 0 AND "departments"."id" = 1 AND "departments"."id" = 2 AND "departments"."id" = 3 AND "departments"."id" = 4',
                pred.to_sql)
  end
end