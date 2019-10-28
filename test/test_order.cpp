/*
 * test_order.cpp
 *
 *  Created on: 2016年9月17日
 *      Author: jing.q.xu
 */

#include "gtest/gtest.h"
#include "local_warehouse.h"
#include "order.h"

TEST(OrderTest, SBAT_fill_order_with_enough_inventory) {
	LocalWarehouse warehouse;
	warehouse.add("book", 100);
	Order order("book", 10);
	ASSERT_EQ(SUCCESS, order.fill(warehouse));
	ASSERT_EQ(100 - 10, warehouse.get_inventory("book"));
}
