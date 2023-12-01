extends Resource

class_name Inventory

signal updated
@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
#	print(items.size())
#	print(item)
	for slot in slots:
		if slot.item == item:
			# if we have reached 5 items break then add to a new stack
			if slot.amount == slot.item.maxAmountPrStack:
				continue
			slot.amount += 1
			updated.emit()
			return
			
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amount = 1
			updated.emit()
			return

