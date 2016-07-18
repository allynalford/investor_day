# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

inv1 = Investor.create(name: "Sequoia")
inv2 = Investor.create(name: "Greylock")
inv3 = Investor.create(name: "Crunchfund")

co1 = Company.create(name: "UserPath")
co2 = Company.create(name: "43Layers")
co3 = Company.create(name: "Zesty")
co4 = Company.create(name: "Iminlikewithyou")
co5 = Company.create(name: "Hypem")

SchedulingBlock.create(start_time: "10:00am", bookable: true)
SchedulingBlock.create(start_time: "10:25am", bookable: true)
SchedulingBlock.create(start_time: "10:50am", bookable: true)
SchedulingBlock.create(start_time: "11:15am", bookable: false)
SchedulingBlock.create(start_time: "11:40am", bookable: true)


# some dummy rankings with a bit of investor groupthink baked in
inv1.rankings << Ranking.create(rankee: co3, score: 9)
inv1.rankings << Ranking.create(rankee: co1, score: 8)
inv1.rankings << Ranking.create(rankee: co5, score: 10)
inv2.rankings << Ranking.create(rankee: co3, score: 9)
inv2.rankings << Ranking.create(rankee: co1, score: 6)
inv2.rankings << Ranking.create(rankee: co2, score: 10)
inv2.rankings << Ranking.create(rankee: co4, score: 10)
inv3.rankings << Ranking.create(rankee: co3, score: 10)

# some dummy company rankings 
co1.rankings << Ranking.create(rankee: inv1, score: 7)
co1.rankings << Ranking.create(rankee: inv2, score: 7)
co2.rankings << Ranking.create(rankee: inv2, score: 10)
co5.rankings << Ranking.create(rankee: inv1, score: 6) # 5
co3.rankings << Ranking.create(rankee: inv1, score: 10)
co3.rankings << Ranking.create(rankee: inv2, score: 6)
co3.rankings << Ranking.create(rankee: inv3, score: 4)
co4.rankings << Ranking.create(rankee: inv2, score: 5)
