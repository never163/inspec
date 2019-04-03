require 'inspec/utils/telemetry'
require_relative '../../../helper.rb'

class TestTelemetryCollector < Minitest::Test
  def setup
    @collector = Inspec::Telemetry::Collector.instance
    @collector.reset
  end

  def test_collector_singleton
    assert_equal Inspec::Telemetry::Collector.instance, @collector
  end

  def test_add_data_series
    data_series = Inspec::Telemetry::DataSeries.new('/resource/File')
    assert @collector.add_data_series(data_series)
  end

  def test_list_data_series
    assert @collector.list_data_series
  end

  def test_list_data_series_names
    data_series = Inspec::Telemetry::DataSeries.new('/resource/File')
    data_series2 = Inspec::Telemetry::DataSeries.new('/resource/Dir')
    @collector.add_data_series(data_series)
    @collector.add_data_series(data_series2)
    list = @collector.list_data_series_by_name('/resource/File')
    assert_kind_of Array, list
    assert_equal 1, list.count
  end

  def test_reset_singleton
    data_series = Inspec::Telemetry::DataSeries.new('/resource/File')
    @collector.add_data_series(data_series)
    @collector.reset
    assert_equal 0, @collector.list_data_series.count
  end
end
