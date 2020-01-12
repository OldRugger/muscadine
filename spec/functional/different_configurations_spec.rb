require 'rails_helper'
require 'sucker_punch'
require 'application_helper'

RSpec.describe TeamResults, type: :job do

  describe "Import excel - day 1" do
    before(:all) do
      clear_all_results
      Config.load
      c = Config.last
     clear_all_results
      c = Config.last
      c.day = 1
      c.unique_id = "Stno"
      c.firstname = "First name"
      c.lastname = "Surname"
      c.gender = "S"
      c.time = "Time"
      c.classifier = "Classifier"
      c.entry_class = "Short"
      c.school = "Text2"
      c.team = "Text3"
      c.jrotc = "Text1"
      c.save
      # load day 00, first file results (small results test)
      source = file_fixture("Different_Configurations/Day 1.xlsx")
      @target = File.join(".", "tmp/results.xlsx")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end

    it "should import runners and teams" do
      expect(Runner.count).to equal(161)
      expect(Team.count).to equal(37)
    end
    it "should calculate day one results " do
      isvm = Day1Awt.where(entryclass: "ISVM").order("runner1_float_time").first
      isvf = Day1Awt.where(entryclass: "ISVF").order("runner1_float_time").first
      isjvm = Day1Awt.where(entryclass: "ISJVM").order("runner1_float_time").first
      isjvf = Day1Awt.where(entryclass: "ISJVF").order("runner1_float_time").first
      isim = Day1Awt.where(entryclass: "ISIM").order("runner1_float_time").first
      isif = Day1Awt.where(entryclass: "ISIF").order("runner1_float_time").first
      expect(isvm.awt_float_time).to eq(56.68888888888889)
      expect(isvf.awt_float_time).to eq(74.93333333333334)
      expect(isjvm.awt_float_time).to eq(34.588888888888896)
      expect(isjvf.awt_float_time).to eq(73.25555555555555)
      expect(isim.awt_float_time).to eq(29.955555555555552)
      expect(isif.awt_float_time).to eq(47.07222222222222)
      isi = Team.where(name: 'Hogwarts INT Gold').first
      expect(isi.day1_score).to eql(167.46402387965827)
      isjv = Team.where(name: 'Hogwarts JV Gold').first
      expect(isjv.day1_score).to eql(176.05249490974202)
      isv = Team.where(name: 'Hogwarts Varsity Gold').first
      expect(isv.day1_score).to eql(179.77993767010634)
    end
  end

  describe "Import excel - day 2" do
    before(:all) do
      c = Config.last
      c.day = 2
      c.time = "Time2"
      c.save
      # load day 00, first file results (small results test)
      source = file_fixture("Different_Configurations/Day 2.xlsx")
      @target = File.join(".", "tmp/results.xlsx")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end

    it "should add one new team" do
      expect(Runner.count).to equal(162)
      expect(Team.count).to equal(37)
    end

    it "should update isi standings" do
      isi = Team.where(entryclass: 'ISI').order(:sort_score, :day1_score, :name)
      expect(isi[0].name).to eq('Hogwarts INT Gold')
      expect(isi[0].total_score.round(3)).to eq(338.120)
      expect(isi[1].name).to eq('Beacon Town 4')
      expect(isi[1].total_score.round(3)).to eq(452.002)
      expect(isi[2].name).to eq('Bel-Air I')
      expect(isi[2].total_score.round(3)).to eq(611.657)
    end

    it "should update isjv standings" do
      isjv = Team.where(entryclass: 'ISJV').order(:sort_score, :day1_score, :name)
      expect(isjv[0].name).to eq('Hogwarts JV Gold')
      expect(isjv[0].total_score.round(3)).to eq(360.761)
      expect(isjv[1].name).to eq('Dillon High JV')
      expect(isjv[1].total_score.round(3)).to eq(427.749)
      expect(isjv[2].name).to eq('Liberty JV #2')
      expect(isjv[2].total_score.round(3)).to eq(521.537)
    end

    it "should update isv standings" do
      isv = Team.where(entryclass: 'ISV').order(:sort_score, :day1_score, :name)
      expect(isv[0].name).to eq('Hogwarts Varsity Gold')
      expect(isv[0].total_score.round(3)).to eq(354.083)
      expect(isv[1].name).to eq('Xavier  Varsity')
      expect(isv[1].total_score.round(3)).to eq(417.773)
      expect(isv[2].name).to eq('Liberty Varsity #1')
      expect(isv[2].total_score.round(3)).to eq(450.466)
    end

  end

end