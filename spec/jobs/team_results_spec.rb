require 'rails_helper'
require 'sucker_punch'

RSpec.describe TeamResults, type: :job do
  describe "Should import results and calculate team results" do
    before(:all) do
      # preload the runners and teams
      Runner.import(fixture_file_upload("OE0010_import_test_data.csv"))
      Team.import(fixture_file_upload("teams.csv"))
      source = file_fixture("OE0013_two_day_results.csv")
      @target = File.join(".", "tmp/OE0013_two_day_results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end

    it "should remove input file" do
      expect(File).not_to exist(@target)
    end

    it "should calculate the Average Waited Times- varsity" do
      isvm = Day1Awt.where(entryclass: "ISVM").order("runner1_float_time").first
      isvf = Day1Awt.where(entryclass: "ISVF").order("runner1_float_time").first
      isjvm = Day1Awt.where(entryclass: "ISJVM").order("runner1_float_time").first
      isjvf = Day1Awt.where(entryclass: "ISJVF").order("runner1_float_time").first
      isim = Day1Awt.where(entryclass: "ISJVM").order("runner1_float_time").first
      isif = Day1Awt.where(entryclass: "ISJVF").order("runner1_float_time").first
      expect(isvm.runner1_float_time).to equal(54.18333333333333)
      expect(isvm.runner2_float_time).to equal(57.65)
      expect(isvm.runner3_float_time).to equal(58.233333333333334)
      expect(isvm.awt_float_time).to equal(56.68888888888889)
      expect(isvf.runner1_float_time).to equal(68.7)
      expect(isvf.runner2_float_time).to equal(76.7)
      expect(isvf.runner3_float_time).to equal(79.4)
      expect(isvf.awt_float_time).to equal(74.93333333333334)

    end

    it "should calculate the Average Waited Times- junior varsity" do
      isjvm = Day1Awt.where(entryclass: "ISJVM").order("runner1_float_time").first
      isjvf = Day1Awt.where(entryclass: "ISJVF").order("runner1_float_time").first
      expect(isjvm.runner1_float_time).to equal(32.46666666666667)
      expect(isjvm.runner2_float_time).to equal(35.36666666666667)
      expect(isjvm.runner3_float_time).to equal(35.93333333333333)
      expect(isjvm.awt_float_time).to equal(34.588888888888896)
      expect(isjvf.runner1_float_time).to equal(67.8)
      expect(isjvf.runner2_float_time).to equal(71.28333333333333)
      expect(isjvf.runner3_float_time).to equal(80.68333333333334)
      expect(isjvf.awt_float_time).to equal(73.25555555555555)
    end

    it "should calculate the Average Waited Times- intermediate" do
      isim = Day1Awt.where(entryclass: "ISIM").order("runner1_float_time").first
      isif = Day1Awt.where(entryclass: "ISIF").order("runner1_float_time").first
      expect(isim.runner1_float_time).to equal(26.333333333333332)
      expect(isim.runner2_float_time).to equal(30.266666666666666)
      expect(isim.runner3_float_time).to equal(33.266666666666666)
      expect(isim.awt_float_time).to equal(29.955555555555552)
      expect(isif.runner1_float_time).to equal(36.233333333333334)
      expect(isif.runner2_float_time).to equal(49.96666666666667)
      expect(isif.runner3_float_time).to equal(55.0166666666666664)
      expect(isif.awt_float_time).to equal(47.07222222222222)
    end

    # TODO - add validations for runner and team scores
  end
end

