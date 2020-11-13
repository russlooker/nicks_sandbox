view: orders {
  sql_table_name: `disco-parsec-659.thelook2.orders`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: order_count_buckets {
    type: tier
    tiers: [1,2,3,6,10]
    style: integer
    sql: ${customer_order_facts.order_count};;
    allow_fill:  no
  }

  dimension: order_amount_buckets {
    type: tier
    tiers: [5, 20, 50, 100, 500, 1000]
    style: classic
    sql:  ${user_id} ;;
  }

  measure: total_profit {
    type: sum
    sql:  ${order_items.profit} ;;
  }

  measure: order_amount {
    type:  sum
    sql: ${order_items.sale_price} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.id, users.first_name, order_items.count]
  }
}
