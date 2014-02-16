b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

b1.beers.create name:"Iso 3", style_id:1
b1.beers.create name:"Karhu", style_id:1
b1.beers.create name:"Tuplahumala", style_id:1
b2.beers.create name:"Huvila Pale Ale", style_id:2
b2.beers.create name:"X Porter", style_id:4
b3.beers.create name:"Hefezeizen", style_id:5
b3.beers.create name:"Helles", style_id:1

User.create username:"pupu", password:"AAA1", password_confirmation:"AAA1", admin:"true"
User.create username:"lupu", password:"AAA1", password_confirmation:"AAA1", admin:"false"

BeerClub.create name:"Kaniinien kaljakerho", founded:1745, city:"Helsinki"
