# Create elastic Ip 
resource "aws_eip" "nat" {
  vpc = true
}


# create nat gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet-a.id
}

# Create route tbale for private subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private_rt"
  }
}


#create private subnet
resource "aws_subnet" "subnet-c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = false

  tags = {
    "Name"                         = "private-a"
    "kubernetes.io/cluster/my-eks" = "shared"
  }


}

resource "aws_subnet" "subnet-d" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = false

  tags = {
    "Name"                         = "private-b"
    "kubernetes.io/cluster/my-eks" = "shared"
  }
}

#assocaite route table with subnets 
resource "aws_route_table_association" "subnet-c" {
  subnet_id      = aws_subnet.subnet-c.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "subnet-d" {
  subnet_id      = aws_subnet.subnet-d.id
  route_table_id = aws_route_table.private_rt.id
}

