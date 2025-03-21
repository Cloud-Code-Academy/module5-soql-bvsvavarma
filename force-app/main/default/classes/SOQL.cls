/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Satya buddharaju Venkata
 * 	
	getAccountsWithContactsByState
 */


public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
		public static List<Lead> getAllLeads(){
			List<Lead> allLeads = [SELECT Id, LastName, Company, Phone, Email FROM Lead LIMIT 200];
			return allLeads;
		}

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
		public static List<Contact> getContactsByFirstName(){
			List<Contact> contactByFirstName= [SELECT Id, Name, FirstName FROM Contact WHERE FirstName = 'John'];
			return contactByFirstName;
		}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
		public static List<Id> getContactIdsByLastName(){
			//List to return all contacts with last name of Smith or Jones
			List<Contact> contactsByLastName = [SELECT Id FROM Contact WHERE LastName IN ('Smith', 'Jones')];
			//List to hold Ids of all contacts with last name of Smith or Jones
			List<Id> contactIdsByLastName = new List<Id>();
			//loop through all contacts with last name of Smith or Jones
			for(Contact contact : contactsByLastName){
				contactIdsByLastName.add(contact.Id);
			}
			return contactIdsByLastName;
		}

	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
		public static List<Opportunity> getClosedWonOpportunityCountByAccount(Id accountId){
			List<Opportunity> closedWonOppotunitiesByAccount = [SELECT 
																		Id,
																		Name, 
																		StageName, 
																		AccountId, 
																		CloseDate, 
																		Amount 
																FROM 
																		Opportunity 
																WHERE 
																		StageName = 'Closed Won' AND AccountId = :accountId
																];
			return closedWonOppotunitiesByAccount;
		}

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
		public static Integer getAccountCount(){
			Integer accountCount = [SELECT COUNT() FROM Account];
			return accountCount;
		}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
		public static Map<Id, Task> getTasksDueNextWeek(){
			Date today = Date.today();
			//Add 7 days to the current date
			Date sevenDaysFromToday = today.addDays(7);

			List<Task> tasksDueNextWeek = [
											SELECT 
												Id, Subject 
											FROM 
												Task 
											WHERE
												ActivityDate >= :today AND ActivityDate <= :sevenDaysFromToday AND IsClosed = false
										  ];
			Map<Id, Task> taskDueNextWeekMap = new Map<Id, Task>();

			for(Task t : tasksDueNextWeek){
				taskDueNextWeekMap.put(t.Id, t);
			}
			return taskDueNextWeekMap;
		}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
		public static List<Contact> getContactsByEmailDomain(){
			String emailDomain = '%' + 'example.com';
			List<Contact> contactsWithEmailDomain = [SELECT Id, Name, FirstName, LastName, Email FROM Contact WHERE Email Like: emailDomain];
			return contactsWithEmailDomain;
		}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		String searchKeyword = '%' + keyword + '%';
		List<Opportunity> optyList = [SELECT Id, Name FROM Opportunity WHERE Name Like: searchKeyword];
		// Replace null with the variable you used to store the result
		return optyList;
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		List<Case> caseByOrigin = [SELECT Id, Origin FROM Case WHERE Origin != null AND Origin != 'Web' AND Origin != 'Email'];
		return caseByOrigin; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String title){
		String titleString = '%' + title + '%';
		List<Lead> leadsBySourceOrTitle  = [SELECT Id, LeadSource, Title, LastName, Company, Phone, Email FROM Lead WHERE LeadSource = :leadSource OR Title Like: titleString];
		return leadsBySourceOrTitle;
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		// Create a list to hold the Contact LastNames
		List<String> contactNames = new List<String>();
		// Query the Contacts
		List<Contact> contactLasrNamesByAccount= [SELECT Id, LastName FROM Contact WHERE AccountId = :accountId];
		// Loop through each Contact and add the LastName to the list
		for (Contact con : contactLasrNamesByAccount) {
			contactNames.add(con.LastName);
		}
		// Return the list of Contact LastNames
		return contactNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		// Use AggregateQuery to get the total revenue
		AggregateResult result = [SELECT SUM(Amount) totalRevenue 
                              FROM Opportunity 
                              WHERE (StageName = :stage OR Amount > 10000)];
		// Return the total revenue

		if(result.get('totalRevenue') != null){
			return (Decimal) result.get('totalRevenue');
		}else{
			return 0.0; 
		}
		 // Replace null with the variable you used to store the result
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		List<Account> accounts= [
									SELECT 
										Id, Name 
									FROM 
										Account 
									ORDER BY 
										NAME ASC 
									LIMIT 10
								];
		return accounts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		List<Opportunity> opportunites = [
											SELECT 
												Id, Name, Amount, CloseDate
											FROM 
												Opportunity 
											WHERE 
												Amount > 100000
											ORDER BY 
												CloseDate
											LIMIT 5
										];
		return opportunites; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		List<Contact> contacts = [
									SELECT 
										Id, LastName, Birthdate
									FROM 
										Contact 
									ORDER BY 
										Birthdate DESC
									LIMIT 3
								];
		return contacts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		List<Case> cases = [
							SELECT 
								Id, Status, CreatedDate
							FROM 
								Case 
							WHERE
								Status ='Open'				
							ORDER BY 
								CreatedDate
							LIMIT 10
							OFFSET 5
						];
		return cases; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		// Create a set to hold the Case Ids
		Set<Id> caseIdsByAccount = new Set<Id>();
		// Query the Cases
		List<Case> cases = [
							SELECT 
								Id, Status
							FROM
								Case
							WHERE 
								AccountId = :accountId
							LIMIT 200
						   ];	
		// Loop through each Case and add the Id to the set
		for (Case ca : cases) {
			caseIdsByAccount.add(ca.id);
		}

		return caseIdsByAccount; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();

		// Query the Accounts
		List<Account> accounts = [SELECT Id, Name FROM Account WHERE BillingCountry != :country];
		// Loop through each Account and add the Id and Name to the map
		for(Account acc : accounts) {
			accountIdsToNames.put(acc.Id, acc.Name);
		}
		return accountIdsToNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		List<Contact> contacts = [SELECT Account.Name FROM Contact WHERE Id = :contactId LIMIT 1];
		if (!contacts.isEmpty() && contacts[0].Account != null) {
            return contacts[0].Account.Name;
        }
		return null; 

		// Replace null with the variable you used to store the result 
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		List<Account> accounts = [SELECT Name, 
									(SELECT Id, Name, Amount, CloseDate, StageName FROM Opportunities)
 								  FROM Account 
 								  WHERE Id = :accountId 
 								  LIMIT 1];
		if(accounts.isEmpty()){
			//return empty Account
			return new Account();
		} else{
			return accounts[0];
		}
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		// Query the Account to get its Billing State
        Account acc = [SELECT BillingState FROM Account WHERE Id = :accountId LIMIT 1];
        // If no account found or BillingState is null, return an empty list
		String billingState = '';
        if (acc == null || acc.BillingState == null) {
            return new List<Contact>();
        }
        // Query Contacts with matching Billing State
        List<Contact> matchingBillingStateContacts = [
            SELECT Id, FirstName, LastName, MailingState, AccountId
            FROM Contact
            WHERE MailingState = :acc.billingState
        ];
        return matchingBillingStateContacts;
	}

	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		// Query the Leads
		List<Lead> leads = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds];
		// Create a set of email domains from the Leads
		Set<String> emailDomains = new Set<String>();
		// Loop through each Lead
		for(Lead lead : leads){
			// Get the email from the Lead
			String email = lead.email;
			// Check if the email is not null
			if(email != null){
				List<String> splitString = lead.Email.split('@');
				// Add the email domain to the set
				if(splitString.size() == 2){
					emailDomains.add(splitString[1]);
				}
			}
		}
		if(emailDomains.isEmpty()){
			return new List<Account>();
		}

		Set<String> websitePatterns = new Set<String>();
		for (String emailDomain : emailDomains) {
			websitePatterns.add('%' + emailDomain);
			websitePatterns.add('%' + emailDomain + '%');
		}

		// Query the Accounts
		String query = 'SELECT Id, Name, Website FROM Account WHERE Website LIKE :websitePatterns';
		List<Account> accounts = Database.Query(query);
		return accounts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
		// Query the original Opportunity Line Items
		List<OpportunityLineItem> origLineItems = [SELECT Id, OpportunityId, Quantity, PricebookEntryId, UnitPrice 
													FROM OpportunityLineItem 
													WHERE OpportunityId = :origOppId];
		// Create a list to hold the new line items
		List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
		// Generate a random number between 1 and 3
		Integer randomQuantity = Integer.valueOf(Math.floor(Math.random() * 3) + 1);
		// Loop through each original line item
		for (OpportunityLineItem origLineItem : origLineItems) {
			// Loop through each cloned Opportunity Id
			for (Id cloneOppId : cloneOppIds) {
				
				OpportunityLineItem newLineItem = new OpportunityLineItem();
				// Clone the original line item and add the random number to the quantity
				newLineItem.Quantity =  origLineItem.Quantity + randomQuantity;
				newLineItem.OpportunityId = cloneOppId;
				newLineItem.PricebookEntryId = origLineItem.PricebookEntryId;
				newLineItem.UnitPrice = origLineItem.UnitPrice;
				newLineItems.add(newLineItem);
			}
		}
		// Insert the new line items
		if(!newLineItems.isEmpty()){
			insert newLineItems;
		}
	}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		List<Opportunity> closedWonOpportunities = [SELECT Name, Account.Name, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won'];
		return closedWonOpportunities; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {

		// 1. Get the Closed Won Opportunities
		List<Opportunity> closedWonOpps = SOQL.getOpportunityDetailsForClosedWon();
    
		// 2. Collect Account IDs
		Set<Id> accountIds = new Set<Id>();
		for (Opportunity opp : closedWonOpps) {
			if (opp.AccountId != null) {
				accountIds.add(opp.AccountId);
			}
		}
		
		// 3. Query Contacts associated with these Accounts
		Map<Id, List<Contact>> accountToContactsMap = new Map<Id, List<Contact>>();
		for (Contact c : [SELECT Id, FirstName, AccountId 
						  FROM Contact 
						  WHERE AccountId IN :accountIds 
						  ORDER BY FirstName ASC]) {
			if (!accountToContactsMap.containsKey(c.AccountId)) {
				accountToContactsMap.put(c.AccountId, new List<Contact>());
			}
			accountToContactsMap.get(c.AccountId).add(c);
		}
		
		// 4. Find the Contact with the alphabetically first name for each Account
		Map<Id, Id> accountToPrimaryContactMap = new Map<Id, Id>();
		for (Id accountId : accountToContactsMap.keySet()) {
			List<Contact> contacts = accountToContactsMap.get(accountId);
			if (!contacts.isEmpty()) {
				accountToPrimaryContactMap.put(accountId, contacts[0].Id);
			}
		}
		
		// 5. Update the Opportunities with the Primary Contact
		List<Opportunity> oppsToUpdate = new List<Opportunity>();
		for (Opportunity opp : closedWonOpps) {
			if (opp.AccountId != null && accountToPrimaryContactMap.containsKey(opp.AccountId)) {
				opp.Primary_Contact__c = accountToPrimaryContactMap.get(opp.AccountId);
				oppsToUpdate.add(opp);
			}
		}
		
		// Perform the update
		if (!oppsToUpdate.isEmpty()) {
			update oppsToUpdate;
		}
	}
}