#create route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

#create public subnet
resource "aws_subnet" "subnet-a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                         = "public-a"
    "kubernetes.io/cluster/my-eks" = "shared"
  }


}

resource "aws_subnet" "subnet-b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                         = "public-b"
    "kubernetes.io/cluster/my-eks" = "shared"
  }
}

#assocaite route table with subnets 
resource "aws_route_table_association" "subnet-a" {
  subnet_id      = aws_subnet.subnet-a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "subnet-b" {
  subnet_id      = aws_subnet.subnet-b.id
  route_table_id = aws_route_table.public_rt.id
}
