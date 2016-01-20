require 'spec_helper'
require 'jill'

describe Jill do
  describe "#run" do
    it "should run" do
      Jill.run("foobar")
    end
  end
end

