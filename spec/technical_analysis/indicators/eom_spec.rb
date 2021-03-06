require 'technical-analysis'
require 'spec_helper'

describe 'Indicators' do
  describe "EoM" do
    input_data = SpecHelper.get_test_data(:high, :low, :volume)
    indicator = TechnicalAnalysis::Eom

    describe 'Ease of Movement' do
      it 'Calculates EoM (14 day)' do
        output = indicator.calculate(input_data, period: 14)
        normalized_output = output.map(&:to_hash)

        expected_output = [
          {:date_time=>"2019-01-09T00:00:00.000Z", :eom=>-6.497226050937367},
          {:date_time=>"2019-01-08T00:00:00.000Z", :eom=>-7.7025655861800235},
          {:date_time=>"2019-01-07T00:00:00.000Z", :eom=>-10.852331038262774},
          {:date_time=>"2019-01-04T00:00:00.000Z", :eom=>-13.901372232239117},
          {:date_time=>"2019-01-03T00:00:00.000Z", :eom=>-14.868322149693872},
          {:date_time=>"2019-01-02T00:00:00.000Z", :eom=>-10.542472341445862},
          {:date_time=>"2018-12-31T00:00:00.000Z", :eom=>-7.266128029998595},
          {:date_time=>"2018-12-28T00:00:00.000Z", :eom=>-11.754905920393293},
          {:date_time=>"2018-12-27T00:00:00.000Z", :eom=>-15.149439471732872},
          {:date_time=>"2018-12-26T00:00:00.000Z", :eom=>-21.397258702024285},
          {:date_time=>"2018-12-24T00:00:00.000Z", :eom=>-29.127850557035778},
          {:date_time=>"2018-12-21T00:00:00.000Z", :eom=>-21.640253827328284},
          {:date_time=>"2018-12-20T00:00:00.000Z", :eom=>-19.510117531121228},
          {:date_time=>"2018-12-19T00:00:00.000Z", :eom=>-14.184550665717635},
          {:date_time=>"2018-12-18T00:00:00.000Z", :eom=>-5.583810139052782},
          {:date_time=>"2018-12-17T00:00:00.000Z", :eom=>-5.714363954096145},
          {:date_time=>"2018-12-14T00:00:00.000Z", :eom=>-5.49920090817078},
          {:date_time=>"2018-12-13T00:00:00.000Z", :eom=>-8.427863395925653},
          {:date_time=>"2018-12-12T00:00:00.000Z", :eom=>-8.897024349696329},
          {:date_time=>"2018-12-11T00:00:00.000Z", :eom=>-15.409243349973261},
          {:date_time=>"2018-12-10T00:00:00.000Z", :eom=>-21.68916026908629},
          {:date_time=>"2018-12-07T00:00:00.000Z", :eom=>-15.003602992747133},
          {:date_time=>"2018-12-06T00:00:00.000Z", :eom=>-14.327931101318542},
          {:date_time=>"2018-12-04T00:00:00.000Z", :eom=>-13.565693513893978},
          {:date_time=>"2018-12-03T00:00:00.000Z", :eom=>-11.780616477806618},
          {:date_time=>"2018-11-30T00:00:00.000Z", :eom=>-20.874548142667777},
          {:date_time=>"2018-11-29T00:00:00.000Z", :eom=>-23.304959556064855},
          {:date_time=>"2018-11-28T00:00:00.000Z", :eom=>-23.906907831421474},
          {:date_time=>"2018-11-27T00:00:00.000Z", :eom=>-24.18360420308819},
          {:date_time=>"2018-11-26T00:00:00.000Z", :eom=>-23.02094878061384},
          {:date_time=>"2018-11-23T00:00:00.000Z", :eom=>-27.26817615617346},
          {:date_time=>"2018-11-21T00:00:00.000Z", :eom=>-28.2247053700715},
          {:date_time=>"2018-11-20T00:00:00.000Z", :eom=>-27.37028760395389},
          {:date_time=>"2018-11-19T00:00:00.000Z", :eom=>-16.94506299946587},
          {:date_time=>"2018-11-16T00:00:00.000Z", :eom=>-13.43297156412281},
          {:date_time=>"2018-11-15T00:00:00.000Z", :eom=>-23.978202090280167},
          {:date_time=>"2018-11-14T00:00:00.000Z", :eom=>-26.374761082588922},
          {:date_time=>"2018-11-13T00:00:00.000Z", :eom=>-22.593717509723117},
          {:date_time=>"2018-11-12T00:00:00.000Z", :eom=>-19.69000228424736},
          {:date_time=>"2018-11-09T00:00:00.000Z", :eom=>-16.918604972309158},
          {:date_time=>"2018-11-08T00:00:00.000Z", :eom=>-11.567473480653877},
          {:date_time=>"2018-11-07T00:00:00.000Z", :eom=>-10.367227984759097},
          {:date_time=>"2018-11-06T00:00:00.000Z", :eom=>-22.183583990006944},
          {:date_time=>"2018-11-05T00:00:00.000Z", :eom=>-22.338003197707696},
          {:date_time=>"2018-11-02T00:00:00.000Z", :eom=>-16.2797807192085},
          {:date_time=>"2018-11-01T00:00:00.000Z", :eom=>-10.135395436615527},
          {:date_time=>"2018-10-31T00:00:00.000Z", :eom=>-6.606596973217312},
          {:date_time=>"2018-10-30T00:00:00.000Z", :eom=>-16.275660385464448},
          {:date_time=>"2018-10-29T00:00:00.000Z", :eom=>-21.877975231994814}
        ]

        expect(normalized_output).to eq(expected_output)
      end

      it "Throws exception if not enough data" do
        expect {indicator.calculate(input_data, period: input_data.size+2)}.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Returns the symbol' do
        indicator_symbol = indicator.indicator_symbol
        expect(indicator_symbol).to eq('eom')
      end

      it 'Returns the name' do
        indicator_name = indicator.indicator_name
        expect(indicator_name).to eq('Ease of Movement')
      end

      it 'Returns the valid options' do
        valid_options = indicator.valid_options
        expect(valid_options).to eq(%i(period))
      end

      it 'Validates options' do
        valid_options = { period: 22 }
        options_validated = indicator.validate_options(valid_options)
        expect(options_validated).to eq(true)
      end

      it 'Throws exception for invalid options' do
        invalid_options = { test: 10 }
        expect { indicator.validate_options(invalid_options) }.to raise_exception(TechnicalAnalysis::Validation::ValidationError)
      end

      it 'Calculates minimum data size' do
        options = { period: 4 }
        expect(indicator.min_data_size(options)).to eq(5)
      end
    end
  end
end
