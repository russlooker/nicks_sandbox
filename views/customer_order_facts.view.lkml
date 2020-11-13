view: customer_order_facts {
  derived_table: {
    sql: select orders.user_id as user_id, count(user_id) as order_count
            from `disco-parsec-659.thelook2.orders` as orders
            group by user_id
             ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    primary_key: yes
#     link: {
#       label: "Foo"
#       url: "/user/dashboard/?id={{id}}"
#     }
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }

  set: detail {
    fields: [user_id, order_count]
  }
}
