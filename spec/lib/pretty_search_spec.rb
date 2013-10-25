# encoding: utf-8
require 'spec_helper'
require_relative '../fake_models'

describe PrettySearch do
  describe '.available_for_use?' do
    let(:model_name) { :company  }
    let(:field_names) { [:title] }

    context 'when hash value is an array' do
      context 'when disabled fields present, and field presents in disabled fields' do
        before { PrettySearch.disabled_fields = {model_name => field_names} }

        it 'shouldn\'t be available for search' do
          expect(PrettySearch.available_for_use?(model_name, field_names)).to be_false
        end
      end

      context 'when enabled_fields present, and field presents in enabled fields' do
        before { PrettySearch.enabled_fields = {model_name => field_names} }

        it 'should be available for search' do
          expect(PrettySearch.available_for_use?(model_name, field_names)).to be_true
        end
      end

      context 'when both, enabled and disabled fields are blank' do
        it 'should be available for search' do
          expect(PrettySearch.available_for_use?(model_name, field_names)).to be_true
        end
      end

      context 'when both, enabled and disabled fields presents' do
        before { PrettySearch.enabled_fields  = {model_name => field_names} }
        before { PrettySearch.disabled_fields = {model_name => field_names} }

        it 'disabled option override enabled, and field shouldn\'t be available for search' do
          expect(PrettySearch.available_for_use?(model_name, field_names)).to be_false
        end
      end

      context 'but when model presents in both, enabled and disabled hashes, but fields wrote in enabled only' do
        before { PrettySearch.enabled_fields  = {model_name => field_names} }
        before { PrettySearch.disabled_fields = {model_name => [:some_other_fields]} }

        it 'all fields written on enabled model should be available' do
          expect(PrettySearch.available_for_use?(model_name, field_names)).to be_true
        end
      end
    end

    context 'when hash value is a :all symbol' do
      context 'when disable all fields in model' do
        before { PrettySearch.disabled_fields  = {model_name => :all} }

        it 'all fields on disabled model shouldn\'t be available' do
          expect(PrettySearch.available_for_use?(model_name, field_names)).to be_false
        end
      end

      context 'when enable all fields in model' do
        before { PrettySearch.enabled_fields  = {model_name => :all} }

        it 'all fields on enabled model should be available' do
          expect(PrettySearch.available_for_use?(model_name, field_names)).to be_true
        end
      end
    end

    after(:each) do
      PrettySearch.disabled_fields = {}
      PrettySearch.enabled_fields = {}
    end
  end
end
