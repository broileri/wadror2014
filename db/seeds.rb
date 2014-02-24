b1 = Brewery.create name:"Koff", year:1897, active:true
b2 = Brewery.create name:"Malmgard", year:2001, active:true
b3 = Brewery.create name:"Weihenstephaner", year:1042, active:true
b3 = Brewery.create name:"Wargen Florgen", year:885, active:false

s1 = Style.create name:"Lager", description:"Normal & boring."
s2 = Style.create name:"IPA", description:"I have no idea what this is."
s3 = Style.create name:"Pale Ale", description:"Pale, like yo momma."
s4 = Style.create name:"Porkkanamehu", description:"Pupujen herkku."
s5 = Style.create name:"Weizen", description:"Wargen florgen."

bb1 = b1.beers.create name:"Iso 3", style_id:s1.id
bb2 = b1.beers.create name:"Karhu", style_id:s1.id
bb3 = b1.beers.create name:"Tuplahumala", style_id:s1.id
bb4 = b2.beers.create name:"Huvila Pale Ale", style_id:s3.id
bb5 = b2.beers.create name:"X Porter", style_id:s2.id
bb6 = b3.beers.create name:"Hefezeizen", style_id:s5.id
bb7 = b3.beers.create name:"Helles", style_id:s1.id
bb8 = b3.beers.create name:"Carrotus I", style_id:s4.id

u1 = User.create username:"pupu", password:"AAA1", password_confirmation:"AAA1", admin:"true"
u2 = User.create username:"lupu", password:"AAA1", password_confirmation:"AAA1", admin:"false"
u3 = User.create username:"väiski", password:"AAA1", password_confirmation:"AAA1", admin:"false"

c1 = BeerClub.create name:"Kaniinien kaljakerho", founded:1745, city:"Helsinki"
c2 = BeerClub.create name:"Jyrsijöiden juomaseura", founded:1846, city:"Kuopio"
c3 = BeerClub.create name:"Pupujen perheolutseura", founded:1662, city:"Puuppola"

Membership.create beer_club_id:c1.id, user_id:u1.id
Membership.create beer_club_id:c2.id, user_id:u1.id
Membership.create beer_club_id:c2.id, user_id:u2.id
Membership.create beer_club_id:c3.id, user_id:u1.id

Rating.create score:26, beer_id:bb1.id, user_id:u1.id
Rating.create score:50, beer_id:bb2.id, user_id:u2.id
Rating.create score:32, beer_id:bb3.id, user_id:u3.id
Rating.create score:41, beer_id:bb4.id, user_id:u1.id
Rating.create score:6, beer_id:bb5.id, user_id:u2.id
Rating.create score:11, beer_id:bb6.id, user_id:u3.id
Rating.create score:41, beer_id:bb7.id, user_id:u1.id
Rating.create score:26, beer_id:bb8.id, user_id:u2.id
Rating.create score:37, beer_id:bb1.id, user_id:u3.id
Rating.create score:12, beer_id:bb2.id, user_id:u1.id
Rating.create score:1, beer_id:bb3.id, user_id:u2.id
Rating.create score:23, beer_id:bb4.id, user_id:u3.id
Rating.create score:45, beer_id:bb5.id, user_id:u1.id
Rating.create score:49, beer_id:bb6.id, user_id:u2.id
Rating.create score:39, beer_id:bb7.id, user_id:u3.id





