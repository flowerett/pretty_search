# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "pretty search routes" do

  it "should route /pretty_search/query/company to pretty_search#search with model_name 'company'" do
    { :get => "/pretty_search/query/company" }.should route_to(:controller => "pretty_search",
                                                               :action     => "search",
                                                               :model_name => "company")
  end
end