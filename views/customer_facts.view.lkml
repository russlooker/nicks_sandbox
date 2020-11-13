view: customer_facts {
  derived_table: {
    sql: select orders.user_id as user_id, sum(order_items.sale_price) as total_customer_value,
        sum(order_items.sale_price - inventory_items.cost) as total_customer_profit
            from `disco-parsec-659.thelook2.orders` as orders
            left join `disco-parsec-659.thelook2.order_items` as order_items on order_items.order_id = orders.id
            left join `disco-parsec-659.thelook2.inventory_items` as inventory_items on inventory_items.id = order_items.inventory_item_id
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
  }

  dimension: total_customer_value {
    type: number
    sql: ${TABLE}.total_customer_value ;;
  }

  dimension: total_customer_profit {
    type: number
    sql:  ${TABLE}.total_customer_profit ;;
  }

  measure: average_customer_value {
    type: average
    sql: ${total_customer_value} ;;
    value_format_name: usd
  }

  measure: average_customer_profit {
    type: average
    sql: ${total_customer_profit} ;;
    value_format_name: usd
  }

  set: detail {
    fields: [user_id, total_customer_value]
  }
}
