# Here I wrote the seed data for my application to test the funcionality of the application
# User.destroy_all

erica = User.create(name: "Erica", email: "erica@erica.com", bio: "I love animals", password: "123")

yoda = User.create(name: "Yoda", email: "yoda@yoda.com", bio: "I love food", password: "123")

Restaurant.create(name: "Denny's", options: "Fit Fare Veggie Sizzlin’ Skillet without egg whites", source: "Denny's website", image_url: "https://dennys.id/wp-content/uploads/2019/04/skillets-veggie.jpg", user_id: erica.id)

Restaurant.create(name: "Outback Steakhouse", options: "House Salad (No Cheese or Croutons)", source: "vegknowledge.com", image_url: "https://az815214.vo.msecnd.net/web/categories/SignatureSideSalad/ccapp-SignatureSideSalad-2x.png", user_id: erica.id)

Restaurant.create(name: "IHOP", options: "Crispy Potato Pancakes", source: "vegknowledge.com", image_url: "https://www.vegknowledge.com/wp-content/uploads/elementor/thumbs/Crispy-Potato-Pancake-e1568671295749-odvg02tax54b43t4v080uuhy1nj9p7jxlmnkqo8r14.jpg", user_id: yoda.id)