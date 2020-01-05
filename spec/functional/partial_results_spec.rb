require 'rails_helper'
require 'sucker_punch'
require 'application_helper'

RSpec.describe TeamResults, type: :job do
  describe "Process partial results first input file - day 1" do
    before(:all) do
      clear_all_results
      Config.load
      Config.last.update(day: 1)
      # load day 00, first file results (small results test)
      source = file_fixture("partial_results/OE0014_day_one_results_00.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end
    it "should import partial runners and teams" do
      expect(Runner.count).to equal(6)
      expect(Team.count).to equal(2)
    end
    it "should calculate the interim varsity average weighted time" do
      isvm = Day1Awt.where(entryclass: "ISVM").order("runner1_float_time").first
      isvf = Day1Awt.where(entryclass: "ISVF").order("runner1_float_time").first
      expect(isvm.runner1_float_time).to equal(102.56666666666666)
      expect(isvm.awt_float_time).to equal(104.85833333333333)
      expect(isvf).to equal(nil)
    end
    it "should calculate the interim jv average weighted time" do
      isjvm = Day1Awt.where(entryclass: "ISJVM").order("runner1_float_time").first
      isjvf = Day1Awt.where(entryclass: "ISJVF").order("runner1_float_time").first
      expect(isjvm.runner1_float_time).to equal(49.88333333333333)
      expect(isjvm.awt_float_time).to equal(79.28333333333335)
      expect(isjvf).to equal(nil)
    end
    it "should calculate the interim intermediate average weighted time" do
      isim = Day1Awt.where(entryclass: "ISJVM").order("runner1_float_time").first
      isif = Day1Awt.where(entryclass: "ISJVF").order("runner1_float_time").first
      expect(isim.runner1_float_time).to equal(49.88333333333333)
      expect(isim.awt_float_time).to equal(79.28333333333335)
      expect(isif).to equal(nil)
    end
    it "should calculate team results" do
      isi = Team.where(entryclass: 'ISI').order(:sort_score, :day1_score, :name)
      isjv = Team.where(entryclass: 'ISJV').order(:sort_score, :day1_score, :name)
      isv = Team.where(entryclass: 'ISV').order(:sort_score, :day1_score, :name)
      expect(isi.count).to equal(0)
      expect(isjv.count).to equal(1)
      expect(isv.count).to equal(1)
      expect(isjv[0].name).to eq("Xavier  JV")
      expect(isjv[0].day1_score).to eql(179.99999999999997)
      expect(isv[0].name).to eq("Xavier  Varsity")
      expect(isv[0].day1_score).to eql(9999.0)
    end
  end

  describe "Process partial results second input file - day 1" do
    before(:all) do
      source = file_fixture("partial_results/OE0014_day_one_results_01.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end
    it "should import partial runners and teams" do
      expect(Runner.count).to equal(56)
      expect(Team.count).to equal(17)
    end
    it "should calculate the interim varsity average weighted time" do
      isvm = Day1Awt.where(entryclass: "ISVM").order("runner1_float_time").first
      isvf = Day1Awt.where(entryclass: "ISVF").order("runner1_float_time").first
      expect(isvm.runner2_float_time).to equal(77.85)
      expect(isvm.awt_float_time).to equal(73.36666666666666)
      expect(isvf.runner2_float_time).to equal(nil)
    end
    it "should calculate team results" do
      isi = Team.where(entryclass: 'ISI').order(:sort_score, :day1_score, :name)
      isjv = Team.where(entryclass: 'ISJV').order(:sort_score, :day1_score, :name)
      isv = Team.where(entryclass: 'ISV').order(:sort_score, :day1_score, :name)
      expect(isi.count).to equal(3)
      expect(isjv.count).to equal(9)
      expect(isv.count).to equal(5)
      expect(isi[1].name).to eq("Glenbrook North I")
      expect(isi[1].day1_score).to eql(9999.0)
      expect(isjv[1].name).to eq("Sunnydale  JV")
      expect(isjv[1].day1_score).to eql(312.42849307597885)
      expect(isv[1].name).to eq("Sunnydale  V")
      expect(isv[1].day1_score).to eql(223.5483870967742)
    end
  end
  describe "Process partial results third input file - day 1" do
    before(:all) do
      source = file_fixture("partial_results/OE0014_day_one_results_02.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end
    it "should import partial runners and teams" do
      expect(Runner.count).to equal(99)
      expect(Team.count).to equal(25)
    end
    it "should calculate the interim junior varsity average weighted time" do
      isjvm = Day1Awt.where(entryclass: "ISJVM").order("runner1_float_time").first
      isjvf = Day1Awt.where(entryclass: "ISJVF").order("runner1_float_time").first
      expect(isjvm.runner3_float_time).to equal(35.93333333333333)
      expect(isjvm.awt_float_time).to equal(34.588888888888896)
      expect(isjvf.runner3_float_time).to equal(92.5)
      expect(isjvf.awt_float_time).to equal(77.19444444444444)
    end
    it "should calculate team results" do
      isi = Team.where(entryclass: 'ISI').order(:sort_score, :day1_score, :name)
      isjv = Team.where(entryclass: 'ISJV').order(:sort_score, :day1_score, :name)
      isv = Team.where(entryclass: 'ISV').order(:sort_score, :day1_score, :name)
      expect(isi.count).to equal(5)
      expect(isjv.count).to equal(12)
      expect(isv.count).to equal(8)
      expect(isi[2].name).to eq("John Adams #2")
      expect(isi[2].day1_score).to eql(322.9032850064232)
      expect(isjv[2].name).to eq("Liberty JV #2")
      expect(isjv[2].day1_score).to eql(269.8843559267587)
      expect(isv[2].name).to eq("Liberty Varsity #1")
      expect(isv[2].day1_score).to eql(230.3892252846208)
    end
  end
  describe "Process partial results forth, fifth input and final file - day 1" do
    before(:all) do
      source = file_fixture("partial_results/OE0014_day_one_results_03.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
      source = file_fixture("partial_results/OE0014_day_one_results_04.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
      source = file_fixture("partial_results/OE0014_day_one_results_final.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end

    it "should import runners and teams" do
      expect(Runner.count).to equal(161)
      expect(Team.count).to equal(37)
    end

    it "should calculate the average weighted time for the day" do
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
    end

    it "should calculate the team results for the day" do
      isi = Team.where(entryclass: 'ISI').order(:sort_score, :day1_score, :name)
      isjv = Team.where(entryclass: 'ISJV').order(:sort_score, :day1_score, :name)
      isv = Team.where(entryclass: 'ISV').order(:sort_score, :day1_score, :name)
      expect(isi[0].name).to eq("Hogwarts INT Gold")
      expect(isi[0].day1_score).to eql(167.46402387965827)
      expect(isjv[0].name).to eq("Hogwarts JV Gold")
      expect(isjv[0].day1_score).to eql(176.05249490974202)
      expect(isv[0].name).to eq("Hogwarts Varsity Gold")
      expect(isv[0].day1_score).to eql(179.77993767010634)
    end
  end

  describe "Process partial results first input file - day 2" do
    before(:all) do
      Config.last.update(day: 2)
      source = file_fixture("partial_results/OE0014_day_two_results_01.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end
    it "should not changed day 1 results" do
      validate_day1_results
      expect(Runner.count).to equal(161)
      expect(Team.count).to equal(37)
    end

    it "should calculate the average weighted time for the day" do
      isvm = Day2Awt.where(entryclass: "ISVM").order("runner1_float_time").first
      isvf = Day2Awt.where(entryclass: "ISVF").order("runner1_float_time").first
      isjvm = Day2Awt.where(entryclass: "ISJVM").order("runner1_float_time").first
      isjvf = Day2Awt.where(entryclass: "ISJVF").order("runner1_float_time").first
      isim = Day2Awt.where(entryclass: "ISIM").order("runner1_float_time").first
      isif = Day2Awt.where(entryclass: "ISIF").order("runner1_float_time").first
      expect(isvm.awt_float_time).to eq(80.69444444444444)
      expect(isvf).to eq(nil)
      expect(isjvm.awt_float_time).to eq(56.21111111111111)
      expect(isjvf.awt_float_time).to eq(71.98333333333333)
      expect(isim.awt_float_time).to eq(47.044444444444444)
      expect(isif).to eq(nil)
    end
  end

  describe "Process partial results second input file - day 2" do
    before(:all) do
      Config.last.update(day: 2)
      source = file_fixture("partial_results/OE0014_day_two_results_02.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end
    it "day1 results should not change" do
      validate_day1_results
    end
    it "should add one new runner - to existing team" do
      expect(Runner.count).to equal(162)
      expect(Team.count).to equal(37)
    end

    it "should add runner 'Road Runner'" do
      runner = Runner.where(firstname: 'Road', surname: 'Runner').first
      expect(runner.database_id).to eql(800)
    end

    it "should add Road Runner to Beacon Town 2" do
      runner = Runner.where(firstname: 'Road', surname: 'Runner').first
      team = Team.where(name: 'Beacon Town 2').last
      TeamMember.where(team_id: team.id).pluck(:runner_id)
      expect(TeamMember.where(team_id: team.id).pluck(:runner_id)).to include(runner.id)
    end

  end

  describe "Process partial results third input file - day 2" do
    before(:all) do
      Config.last.update(day: 2)
      source = file_fixture("partial_results/OE0014_day_two_results_03.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end
    it "day1 results should not change" do
      validate_day1_results
    end
    it "should not change runner/team counts" do
      expect(Runner.count).to equal(162)
      expect(Team.count).to equal(37)
    end

    it "should update standings" do
      isi = Team.where(entryclass: 'ISI').order(:sort_score, :day1_score, :name)
      isjv = Team.where(entryclass: 'ISJV').order(:sort_score, :day1_score, :name)
      isv = Team.where(entryclass: 'ISV').order(:sort_score, :day1_score, :name)
      expect(isi[0].name).to eq('Beacon Town 4')
      expect(isi[1].name).to eq('Bel-Air I')
      expect(isi[2].name).to eq('John Adams #2')
      expect(isjv[0].name).to eq('Hogwarts JV Gold')
      expect(isjv[1].name).to eq('Liberty JV #2')
      expect(isjv[2].name).to eq('Beacon Town 2')
      expect(isv[0].name).to eq('Hogwarts Varsity Gold')
      expect(isv[1].name).to eq('Xavier  Varsity')
      expect(isv[2].name).to eq('Bel-Air V')
    end
  end

    describe "Process partial results forth and final file - day 2" do
    before(:all) do
      Config.last.update(day: 2)
      source = file_fixture("partial_results/OE0014_day_two_results_04.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
      Config.last.update(day: 2)
      source = file_fixture("partial_results/OE0014_day_two_results_final.csv")
      @target = File.join(".", "tmp/results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end
    it "day1 results should not change" do
      validate_day1_results
    end
    it "should not change runner/team counts" do
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

  def validate_day1_results
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