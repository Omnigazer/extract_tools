RSpec.describe ImageExtractor do
  context 'when an invalid url is supplied' do
    let(:url) { "some garbage string 123" }
    let(:extractor) { ImageExtractor.new(url) }

    it 'throws an error' do
      expect { extractor }.to raise_error(ArgumentError)
    end
  end

  context 'when a valid url is supplied' do
    let(:url) { "http://google.com" }
    let(:extractor) { ImageExtractor.new(url) }

    describe '.extract_images' do
      let(:results) { extractor.extract_images }

      context "when the page isn't found" do
        before { stub_request(:get, url).to_return(status: 404) }
        it "raises a response error" do
          expect { results }.to raise_error(ResponseError)
        end
      end

      context "when the page returns 500" do
        before { stub_request(:get, url).to_return(status: 500) }
        it "raises a response error" do
          expect { results }.to raise_error(ResponseError)
        end
      end

      context 'when the page contains 3 valid image links' do
        before { stub_request(:get, url).to_return(status: 200, body: "<img src='http://google.com/1.png'/><img src='http://google.com/2.png'/><img src='http://google.com/3.png'/>") }
        it 'returns an array of 3 valid urls' do
          expect(results).to be_a(Array)
          results.each do |image_url|
            expect(image_url).to match(URI::regexp)
          end
          expect(results.length).to eq(3)
        end
      end

      context 'when the page contains relative image links' do
        before { stub_request(:get, url).to_return(status: 200, body: "<img src='tia.png'/><img src='http://google.com/img.png'/>") }
        it 'returns the same number of absolute urls' do
          expect(results).to be_a(Array)
          results.each do |image_url|
            expect(image_url).to match(URI::regexp)
          end
          expect(results.length).to eq(2)
        end
      end
    end
  end
end
