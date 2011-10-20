package com.medfire

import com.medfire.User

/**
 * Authority domain class.
 */
class Role {
	static auditable = true

	static hasMany = [people: User]

	/** description */
	String description
	/** ROLE String */
	String authority

	static constraints = {
		authority(blank: false, unique: true)
		description()
	}
}
