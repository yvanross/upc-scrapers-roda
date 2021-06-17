
require_relative '../../lib/heartbeat.rb'
require_relative '../spec_helper'
RSpec.describe Heartbeat do
  describe 'Heartbeat' do
   
    it "raise an error if PORT is not set" do
      ENV['PORT']=nil
      expect{Heartbeat.new}.to raise_error(StandardError,'PORT environement variable not defined')
    end 

    describe 'with PORT'do 
      before(:each) do
        ENV['PORT']="3000"
      end
      
      it "raise an error if environement variable is not set" do
        ENV['UPC_LOOKUP_GATEWAY_PORT'] = nil
        expect{Heartbeat.new}.to raise_error(StandardError,'UPC_LOOKUP_GATEWAY_PORT environement variable not defined')
      end 

      describe "with UPC_LOOKUP_GATEWAY_PORT defined " do 

        before(:each) do
          ENV['UPC_LOOKUP_GATEWAY_PORT'] = "6300"
        end

        it "raise an error if environement variable is not set" do
          ENV['HEARTBEAT_FREQUENCY']=nil
          expect{Heartbeat.new}.to raise_error(StandardError,'HEARTBEAT_FREQUENCY environement variable not defined')
        end 

        it 'do not raise error if environement variable is set' do
          ENV['HEARTBEAT_FREQUENCY'] = "1"
          Heartbeat.new
        end
      end
    end
  end
end 