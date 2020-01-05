require 'rails_helper'
require 'sucker_punch'
require 'application_helper'

RSpec.describe TeamResults, type: :job do
  describe "SEIS 2019 Results - day 1" do
    before(:all) do
      clear_all_results
      Config.load
      c = Config.last
      c.day = 1
      c.unique_id = "Stno"
      c.firstname = "First name"
      c.lastname = "Surname"
      c.gender = "S"
      c.time = "Time2"
      c.classifier = "Classifier2"
      c.entry_class = "Short"
      c.school = "Text2"
      c.team = "Text3"
      c.save
      # load day 00, first file results (small results test)
      source = file_fixture("seis_2019/IS_Results_Classes_GNC19_Sat_8.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end

    it "should create runners and teams" do
      expect(Runner.count).to equal(76)
      expect(Team.count).to equal(19)
    end

    it "should calculate day 1 varsity scores" do
      teams = Team.where(entryclass: "ISV").order(:sort_score).all
      expect(teams[0].name).to eq("Hillgrove Crimson")
      expect(teams[0].day1_score.round(3)).to eq(180.615)
      expect(teams[1].name).to eq("Warhawks GOLD")
      expect(teams[1].day1_score.round(3)).to eq(181.009)
      expect(teams[2].name).to eq("UGHS")
      expect(teams[2].day1_score.round(3)).to eq(265.473)
    end

    it "should calculate day 1 junior varsity scores" do
      teams = Team.where(entryclass: "ISJV").order(:sort_score).all
      expect(teams[0].name).to eq("Warhawks GOLD")
      expect(teams[0].day1_score.round(3)).to eq(169.472)
      expect(teams[1].name).to eq("Hillgrove Crimson")
      expect(teams[1].day1_score.round(3)).to eq(203.542)
      expect(teams[2].name).to eq("Hillgrove Silver")
      expect(teams[2].day1_score.round(3)).to eq(205.804)
    end

    it "should calculate day 1 ISI scores" do
      teams = Team.where(entryclass: "ISI").order(:sort_score).all
      expect(teams[0].name).to eq("Hillgrove Crimson")
      expect(teams[0].day1_score.round(3)).to eq(168.773)
      expect(teams[1].name).to eq("Warhawks GOLD")
      expect(teams[1].day1_score.round(3)).to eq(197.919)
      expect(teams[2].name).to eq("Wren NJROTC")
      expect(teams[2].day1_score.round(3)).to eq(266.649)
    end

  end

  describe "SEIS 2019 Results - day 2" do
    before(:all) do
      Config.load
      c = Config.last
      c.day = 2
      c.time = "Time3"
      c.classifier = "Classifier3"
      c.save
      # load day 00, first file results (small results test)
      source = file_fixture("seis_2019/IS_Results_Classes_GNC19_Sun_10.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end

    it "should not change day 1 results" do
      expect(Team.where(entryclass: "ISV", name:"Hillgrove Crimson").first.day1_score.round(3)).to eq(180.615)
      expect(Team.where(entryclass: "ISJV", name:"Warhawks GOLD").first.day1_score.round(3)).to eq(169.472)
      expect(Team.where(entryclass: "ISI", name:"Hillgrove Crimson").first.day1_score.round(3)).to eq(168.773)
    end

    it "should add 1 runner" do
      expect(Runner.count).to equal(79)
      expect(Team.count).to equal(19)
    end

    it "should calculate day 2 varsity scores" do
      teams = Team.where(entryclass: "ISV").order(:sort_score).all
      expect(teams[0].name).to eq("Warhawks GOLD")
      expect(teams[0].day2_score.round(3)).to eq(171.88)
      expect(teams[1].name).to eq("Hillgrove Crimson")
      expect(teams[1].day2_score.round(3)).to eq(189.44)
      expect(teams[2].name).to eq("UGHS")
      expect(teams[2].day2_score.round(3)).to eq(245.803)
    end

    it "should calculate day 2 junior varsity scores" do
      teams = Team.where(entryclass: "ISJV").order(:sort_score).all
      expect(teams[0].name).to eq("Warhawks GOLD")
      expect(teams[0].day2_score.round(3)).to eq(180.386)
      expect(teams[1].name).to eq("Hillgrove Crimson")
      expect(teams[1].day2_score.round(3)).to eq(182.354)
      expect(teams[2].name).to eq("Hillgrove Silver")
      expect(teams[2].day2_score.round(3)).to eq(220.572)
    end

    it "should calculate day 2 junior varsity scores" do
      teams = Team.where(entryclass: "ISI").order(:sort_score).all
      expect(teams[0].name).to eq("Warhawks GOLD")
      expect(teams[0].day2_score.round(3)).to eq(192.356)
      expect(teams[1].name).to eq("Hillgrove Crimson")
      expect(teams[1].day2_score.round(3)).to eq(229.955)
      expect(teams[2].name).to eq("Wren NJROTC")
      expect(teams[2].day2_score.round(3)).to eq(297.111)
    end

    it "should calculate total scores" do
      expect(Team.where(entryclass: "ISV", name:"Hillgrove Crimson").first.total_score.round(2)).to eq(370.05)
      expect(Team.where(entryclass: "ISJV", name:"Warhawks GOLD").first.total_score.round(2)).to eq(349.86)
      expect(Team.where(entryclass: "ISI", name:"Hillgrove Crimson").first.total_score.round(2)).to eq(398.73)
    end

  end

end