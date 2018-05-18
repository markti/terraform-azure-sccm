

resource "azurerm_application_security_group" "cer-asg" {
  name                = "${var.prefix}-cer-asg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_network_security_group" "cer-nsg" {

	name                = "${var.prefix}-cer-nsg"
	location            = "${var.location}"
	resource_group_name = "${var.resource_group_name}"

}



/*

Active Directory and Active Directory Domain Services Port Requirements
https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd772723(v=ws.10)

*/

/*************************************************
TCP and UDP 389

Directory, Replication, User and Computer Authentication, Group Policy, Trusts

LDAP
*/
resource "azurerm_network_security_rule" "ad_ldap" {
	name                        = "LDAP"
	priority                    = 1100
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "*"
	source_port_range           = "*"
	destination_port_range      = "389"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP 636

Directory, Replication, User and Computer Authentication, Group Policy, Trusts

LDAP SSL
*/
resource "azurerm_network_security_rule" "ad_ldap_ssl" {
	name                        = "LDAP_SSL"
	priority                    = 1101
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "636"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP 3268

Directory, Replication, User and Computer Authentication, Group Policy, Trusts

LDAP GC
*************************************************/
resource "azurerm_network_security_rule" "ad_ldap_gc" {
	name                        = "LDAP_GC"
	priority                    = 1102
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "3268"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP 3269

Directory, Replication, User and Computer Authentication, Group Policy, Trusts

LDAP GC SSL
*/
resource "azurerm_network_security_rule" "ad_ldap_gc_ssl" {
	name                        = "LDAP_GC_SSL"
	priority                    = 1103
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "3269"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP and UDP 88

User and Computer Authentication, Forest Level Trusts

Kerberos
*/
resource "azurerm_network_security_rule" "ad_ldap_kerberos" {
	name                        = "Kerberos"
	priority                    = 1104
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "*"
	source_port_range           = "*"
	destination_port_range      = "88"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP and UDP 53

User and Computer Authentication, Name Resolution, Trusts

DNS
*/
resource "azurerm_network_security_rule" "ad_dns" {
	name                        = "DNS"
	priority                    = 1105
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "*"
	source_port_range           = "*"
	destination_port_range      = "53"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP and UDP 445

Replication, User and Computer Authentication, Group Policy, Trusts

SMB,CIFS,SMB2, DFSN, LSARPC, NbtSS, NetLogonR, SamR, SrvSvc
*/
resource "azurerm_network_security_rule" "ad_smb" {
	name                        = "SMB"
	priority                    = 1106
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "*"
	source_port_range           = "*"
	destination_port_range      = "445"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP 25

Replication

SMTP
*/
resource "azurerm_network_security_rule" "ad_smtp" {
	name                        = "SMTP"
	priority                    = 1107
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "25"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP 135

Replication

RPC, EPM
*/
resource "azurerm_network_security_rule" "ad_rpc" {
	name                        = "RPC"
	priority                    = 1108
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "135"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP Dynamic

Replication, User and Computer Authentication, Group Policy, Trusts

RPC, DCOM, EPM, DRSUAPI, NetLogonR, SamR, FRS
*/

/*************************************************
TCP 5722

File Replication

RPC, DFSR (SYSVOL)
*/
resource "azurerm_network_security_rule" "ad_rpc_dfsr" {
	name                        = "RPC_DFSR"
	priority                    = 1109
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "5722"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
UDP 123

Windows Time, Trusts

Windows Time
*/
resource "azurerm_network_security_rule" "ad_wintime" {
	name                        = "WindowsTime"
	priority                    = 1110
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Udp"
	source_port_range           = "*"
	destination_port_range      = "123"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP and UDP 464

Replication, User and Computer Authentication, Trusts

Kerberos change/set password
*/
resource "azurerm_network_security_rule" "ad_kerberos_passwordreset" {
	name                        = "Kerberos_PasswordReset"
	priority                    = 1111
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "*"
	source_port_range           = "*"
	destination_port_range      = "464"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
UDP Dynamic

Group Policy

DCOM, RPC, EPM
*/
resource "azurerm_network_security_rule" "ad_dcom" {
	name                        = "DCOM"
	priority                    = 1112
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "*"
	source_port_range           = "*"
	destination_port_range      = "dynamic"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
UDP 138

DFS, Group Policy

DFSN, NetLogon, NetBIOS Datagram Service
*/
resource "azurerm_network_security_rule" "ad_netbios_dgs" {
	name                        = "NetBIOS_DGS"
	priority                    = 1113
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Udp"
	source_port_range           = "*"
	destination_port_range      = "138"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP 9389

AD DS Web Services

SOAP
*/
resource "azurerm_network_security_rule" "ad_adds_web" {
	name                        = "ADDS_Web"
	priority                    = 1114
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "9389"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
UDP 67 and UDP 2535

DHCP

Note
DHCP is not a core AD DS service but it is often present in many AD DS deployments.
DHCP, MADCAP
*/
resource "azurerm_network_security_rule" "ad_dhcp" {
	name                        = "DHCP"
	priority                    = 1115
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Udp"
	source_port_range           = "*"
	destination_port_range      = "67,2535"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
UDP 137

User and Computer Authentication,

NetLogon, NetBIOS Name Resolution
*/
resource "azurerm_network_security_rule" "ad_netbios" {
	name                        = "NetBIOS"
	priority                    = 1116
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Udp"
	source_port_range           = "*"
	destination_port_range      = "137"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}

/*************************************************
TCP 139

User and Computer Authentication, Replication

DFSN, NetBIOS Session Service, NetLogon
*/
resource "azurerm_network_security_rule" "ad_netbios_dfsn" {
	name                        = "NetBIOS_DFSN"
	priority                    = 1117
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "139"
	
	source_application_security_group_ids = ["${var.cer_asg_id}", "${var.mtg_asg_id}", "${var.msc_asg_id}", "${var.sql_asg_id}"]
	destination_application_security_group_ids	= ["${var.mad_asg_id}"]

	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${var.mad_nsg_id}"
}