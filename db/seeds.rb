Anime.delete_all
User.delete_all
Review.delete_all


user1 = User.create(username: 'name1', password: 'pass1', pin: 1234)
user2 = User.create(username: 'name2', password: 'pass2', pin: 1111)
user3 = User.create(username: 'name3', password: 'pass3', pin: 2222)
user4 = User.create(username: 'name4', password: 'pass4', pin: 3333)
user5 = User.create(username: 'name5', password: 'pass5', pin: 4444)


# naruto = Anime.create(name: "Naruto", synopsis: "Moments prior to Naruto Uzumaki's birth, a huge demon known as the Kyuubi, the Nine-Tailed Fox, attacked Konohagakure, the Hidden Leaf Village, and wreaked havoc. In order to put an end to the Kyuubi's rampage, the leader of the village, the Fourth Hokage, sacrificed his life and sealed the monstrous beast inside the newborn Naruto. Now, Naruto is a hyperactive and knuckle-headed ninja still living in Konohagakure. Shunned because of the Kyuubi inside him, Naruto struggles to find his place in the village, while his burning desire to become the Hokage of Konohagakure leads him not only to some great new friends, but also some deadly foes.
# ")
# cowboy = Anime.create(name: "Cowboy Bebop", synopsis: "In the year 2071, humanity has colonized several of the planets and moons of the solar system leaving the now uninhabitable surface of planet Earth behind. The Inter Solar System Police attempts to keep peace in the galaxy, aided in part by outlaw bounty hunters, referred to as 'Cowboys'. The ragtag team aboard the spaceship Bebop are two such individuals. Mellow and carefree Spike Spiegel is balanced by his boisterous, pragmatic partner Jet Black as the pair makes a living chasing bounties and collecting rewards. Thrown off course by the addition of new members that they meet in their travels—Ein, a genetically engineered, highly intelligent Welsh Corgi; femme fatale Faye Valentine, an enigmatic trickster with memory loss; and the strange computer whiz kid Edward Wong—the crew embarks on thrilling adventures that unravel each member's dark and mysterious past little by little.")
# fma = Anime.create(name: "Fullmetal Alchemist: Brotherhood", synopsis: "Fullmetal Alchemist: Brotherhood is an alternate retelling of Hiromu Arakawa's Fullmetal Alchemist manga that is closer to the source material than the previous 2003 adaptation, this time covering the entire story.
# ")
# ttgl = Anime.create(name: "Tengen Toppa Gurren Lagann", synopsis: "Simon and Kamina were born and raised in a deep, underground village, hidden from the fabled surface. Kamina is a free-spirited loose cannon bent on making a name for himself, while Simon is a timid young boy with no real aspirations. One day while excavating the earth, Simon stumbles upon a mysterious object that turns out to be the ignition key to an ancient artifact of war, which the duo dubs Lagann. Using their new weapon, Simon and Kamina fend off a surprise attack from the surface with the help of Yoko Littner, a hot-blooded redhead wielding a massive gun who wanders the world above.")
# opm = Anime.create(name: "One Punch Man", synopsis: "The seemingly ordinary and unimpressive Saitama has a rather unique hobby: being a hero. In order to pursue his childhood dream, he trained relentlessly for three years—and lost all of his hair in the process. Now, Saitama is incredibly powerful, so much so that no enemy is able to defeat him in battle. In fact, all it takes to defeat evildoers with just one punch has led to an unexpected problem—he is no longer able to enjoy the thrill of battling and has become quite bored.")
# ynn = Anime.create(name: "Yakusoku no Neverland", synopsis: "Surrounded by a forest and a gated entrance, the Grace Field House is inhabited by orphans happily living together as one big family, looked after by their 'Mama,' Isabella. Although they are required to take tests daily, the children are free to spend their time as they see fit, usually playing outside, as long as they do not venture too far from the orphanage—a rule they are expected to follow no matter what. However, all good times must come to an end, as every few months, a child is adopted and sent to live with their new family... never to be heard from again.")



# review10 = Review.create(user_id: user1.id, review: "Awesome", anime_id: naruto.id, rating: 10)
# review11 = Review.create(user_id: user2.id, review: "Cool", anime_id: naruto.id, rating: 7)
# review12 = Review.create(user_id: user3.id, review: "Great", anime_id: cowboy.id, rating: 8)
# review13 = Review.create(user_id: user4.id, review: "Not my cup of tea", anime_id: fma.id, rating: 3)
# review14 = Review.create(user_id: user5.id, review: "10/10 would recommend", anime_id: opm.id, rating: 10)




