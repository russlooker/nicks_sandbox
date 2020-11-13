view: order_facts {
  derived_table: {
    sql: select order_items.sale_price,
       inventory_items.cost,
       inventory_items.sold_at as inventory_sold_at,
       order_items.order_id,
       inventory_items.product_id,
       order_items.returned_at,
       orders.campaign,
       orders.status,
       orders.user_id,
       orders.created_at
            from `disco-parsec-659.thelook2.order_items` as order_items
            inner join `disco-parsec-659.thelook2.inventory_items` as inventory_items on inventory_items.id = order_items.inventory_item_id
            left join `disco-parsec-659.thelook2.orders` as orders on orders.id = order_items.order_id
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: inventory_sold_at {
    type: time
    sql: ${TABLE}.inventory_sold_at ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: returned_at {
    type: time
    sql: ${TABLE}.returned_at ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: profit {
    type: number
    sql: ${sale_price} - ${cost} ;;
  }

  measure: avg_profit {
    type: average
    sql:  ${profit} ;;
    value_format_name: usd
  }

  measure: customer_value {
    type: sum
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
  }

  set: detail {
    fields: [
      sale_price,
      cost,
      inventory_sold_at_time,
      order_id,
      product_id,
      returned_at_time,
      campaign,
      status,
      user_id,
      created_at_time
    ]
  }
}
