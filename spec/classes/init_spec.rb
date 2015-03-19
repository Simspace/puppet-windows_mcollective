require 'spec_helper'
describe 'windows_mcollective' do

  context 'with defaults for all parameters' do
    it { should contain_class('windows_mcollective') }
  end
end
