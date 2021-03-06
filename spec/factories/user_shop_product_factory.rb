FactoryGirl.define do
  PROFILE_PIC ||= File.open(Rails.root.join('spec/fixtures/profile_pic.jpg'))
  IMAGE_ONE ||= File.open(Rails.root.join("spec/fixtures/cake1.jpg"))
  IMAGE_TWO ||= File.open(Rails.root.join("spec/fixtures/cake2.jpg"))
  IMAGE_THREE ||= File.open(Rails.root.join("spec/fixtures/cake3.jpg"))
  IMAGE_FOUR ||= File.open(Rails.root.join("spec/fixtures/cake4.jpg"))
  SHOP_BANNER ||= File.open(Rails.root.join("spec/fixtures/shop_banner.jpg"))

  


  factory :tag do
    category_list = ["birthday", "anniversary", "party", "celebration", "New Year", "Christmas", "wedding anniversary", 
      "wedding cake"]
    name { category_list[rand(0..6)] }

    factory :tag_with_products do 
      transient do 
        products_count 2
      end

      after(:create) do |tag, evaluator|
        create_list(:product, evaluator.products_count, tags: [tag])
      end
    end

    factory :tag_with_orders do 
      transient do 
        orders_count 2
      end

      after(:create) do |tag, evaluator|
        create_list(:order, evaluator.orders_count, tags: [tag])
      end
    end
  end


  factory :product do
    product_list = ["chocolate cake", "vanilla cake", "strawberry cake", "plain cake"]
    size = ["small", "medium", "large"]
    name { product_list[rand(0..3)] }
    description "some random description"
    price { rand(1..500).to_f }
    size { size[rand(0..2)] }
    imageone Rack::Test::UploadedFile.new IMAGE_ONE
    imagetwo Rack::Test::UploadedFile.new IMAGE_TWO
    imagethree Rack::Test::UploadedFile.new IMAGE_THREE
    imagefour Rack::Test::UploadedFile.new IMAGE_FOUR
    user

    trait :approved do 
       approved false
    end



    factory :product_with_tags do
      transient do 
        tags_count 2
      end 

      after(:create) do |product, evaluator|
        create_list(:tag, evaluator.tags_count, products: [product])
      end
    end
  end

  factory :order do
    size_list = ["small", "medium", "large"]
    city_list = ["accra", "kumasi", "east legon", "madina", "circle"]
    description { FFaker::Lorem.paragraph }
    min_price { rand(1..500).to_f }
    max_price { (rand(1..500).to_f) + 100 }
    size { size_list[rand(0..2)] }
    delivery_date { DateTime.now + (rand(1..10)).hours }
    recipient_address { city_list[rand(0..4)] }
    recipient_name { FFaker::Name.name }
    recipient_phonenumber "024345678"
    recipient_email { FFaker::Internet.email }
    # sample_picture "MyString"
    user 

    factory :order_with_tags do 
      transient do 
        tags_count 2
      end

      after(:create) do |order, evaluator|
        create_list(:tag, evaluator.tags_count, orders: [order])
      end
    end
  end





  factory :shop do 
    city_list = ["accra", "kumasi", "east legon", "madina", "circle"]
    name { FFaker::Company.name }
    description { FFaker::Lorem.paragraph }
    location { city_list[rand(0..4)] }
    opening { DateTime.now }
    closing { DateTime.now + 6.hours }
    image Rack::Test::UploadedFile.new SHOP_BANNER
    user 

    trait :approved do 
       approved false
    end


    factory :shop_with_products do 
      transient do
        products_count 10 
      end

      after(:create) do |shop, evaluator|
        create_list(:product, evaluator.products_count, shop: shop)
      end
    end
  end










  factory :user do
  	email { FFaker::Internet.email }
  	password "password"
  	password_confirmation "password"
  	username { FFaker::Name.first_name}
    fullname { FFaker::Name.name }
  	first_name { FFaker::Name.first_name }
  	last_name { FFaker::Name.last_name } 
    phonenumber "0204704427"
    image Rack::Test::UploadedFile.new(PROFILE_PIC)


  	trait :admin do 
      admin true
    end   

    trait :seller do
      seller true
    end

    trait :sex do 
      sex 'female'
    end

    trait :suspended do 
       suspended false
    end



    factory :user_with_shops do 
      transient do 
        shops_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:shop, evaluator.shops_count, user: user )
      end

      factory :user_with_products do 
        transient do 
          products_count 10
        end

        after(:create) do |user, evaluator|
          create_list(:product, evaluator.products_count, user: user)
        end
      end

    end
  end
end
