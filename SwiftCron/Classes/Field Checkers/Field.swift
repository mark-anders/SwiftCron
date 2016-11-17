import Foundation

class Field
{
	var fields: NSMutableArray?

    /**
     * Check to see if a field is satisfied by a value
     *
     * - parameter dateValue: Date value to check
     * - parameter value: Value to test
     *
     * - Returns: Bool
     */
	func isSatisfied(dateValue: String, value: String) -> Bool
	{
		if isIncrementsOfRanges(value)
		{
			return isInIncrementsOfRanges(dateValue, withValue: value)
		}
		else if isRange(value)
		{
			return isInRange(dateValue, withValue: value)
		}

		return value == "*" || dateValue == value
	}

    /**
     * Check if a string value is a range (i.e. contains '-')
     *
     * - parameter value: Value to test
     *
     * - Returns: Bool
     */
	func isRange(value: String) -> Bool
	{
		return value.rangeOfString("-") != nil
	}

    /**
     * Check if a value is an increments of ranges
     *
     * - parameter value: Value to test
     *
     * - Returns: Bool
     */
	func isIncrementsOfRanges(value: String) -> Bool
	{
		return value.rangeOfString("/") != nil
	}

    /**
     * Test if a value is within a range
     *
     * - parameter dateValue: Set date value
     * - parameter withValue: Value to test
     *
     * - Returns: Bool
     */
	func isInRange(dateValue: String, withValue value: String) -> Bool
	{
		let parts = value.componentsSeparatedByString("-")

		return Int(dateValue) >= Int(parts[0]) && Int(dateValue) <= Int(parts[1])
	}

    /**
     * Test if a value is within an increments of ranges (offset[-to]/step size)
     *
     * - parameter dateValue: Set date value
     * - parameter value: Value to test
     *
     * - Returns: Bool
     */
	func isInIncrementsOfRanges(dateValue: String, withValue value: String) -> Bool
	{
		let parts = value.componentsSeparatedByString("/")
		if parts[0] != "*" && Int(parts[0]) != 0
		{
			guard parts[0].rangeOfString("-") != nil else
			{
				NSLog("Cannot increment a range! \(value)")
				return false
			}

			let range = parts[0].componentsSeparatedByString("-")
			if Int(dateValue) == Int(range[0])
			{
				return true
			}
			else if Int(dateValue) < Int(range[0])
			{
				return false
			}
		}

		return Int(dateValue)! % Int(parts[1])! == 0
	}
}
