{
  _id: <ObjectId2>,
  name: String,
  slogan: String,
  Description: String,
  Category: {
    _id: <ObjectId3>,
    name: String
  },
  default_price: Number,
  features_id: {
    _id: <ObjectId4>,
    feature: String,
    value: String
  },
  styles: {
    id: <ObjectId5>,
    name: String,
    original_price: Number,
    sale_price: Number,
    default?: Boolean,
    photos: [{
      id: <ObjectId6>,
      thumbnail_url: String,
      url: String
    }, ... ],
    skus: {
      id: <ObjectId7>,
      quantity: Number,
      size: String
    }
  },
  created_at: Date,
  updated_at: Date,
  related_products: {
    id: <ObjectId8>,
    product_id: Number
  }
  reviews: [{
    meta_id: Number,
    reviews_id: Number
  }, ...],
  questions: {
    questions_id: Number
  }
}