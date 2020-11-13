connection: "disco-parsec"
include: "/views/*"

explore: order_items {
  join: inventory_items {
    type: left_outer
    relationship: one_to_one
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
  }
  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
  }
  join: orders {
    type: inner
    relationship: one_to_many
    sql_on:  ${orders.id} = ${order_items.order_id} ;;
  }
  join: users {
    type: inner
    relationship: one_to_many
    sql_on: ${users.id} = ${orders.user_id} ;;
  }
  join: active_users {
    type: inner
    relationship: one_to_many
    sql_on: ${activity_users.user_id} = ${users.id} ;;
  }
  join: customer_facts {
    type: inner
    relationship: many_to_many
    sql_on: ${customer_facts.user_id} = ${users.id} ;;
  }
  join: customer_order_facts {
    type: inner
    relationship: one_to_one
    sql_on: ${customer_order_facts.user_id} = ${users.id} ;;
  }
  join: order_facts {
    type: left_outer
    relationship: one_to_one
    sql_on: ${order_facts.user_id} = ${users.id} ;;
  }
}

explore: order_items_detail {
  from: order_items
  extends: [order_items]
}
