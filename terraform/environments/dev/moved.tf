# Preserve existing state addresses after moving VPC resources into the module.

moved {
  from = aws_vpc.main
  to   = module.vpc.aws_vpc.main
}

moved {
  from = aws_internet_gateway.main
  to   = module.vpc.aws_internet_gateway.main
}

moved {
  from = aws_subnet.public[0]
  to   = module.vpc.aws_subnet.public[0]
}

moved {
  from = aws_subnet.public[1]
  to   = module.vpc.aws_subnet.public[1]
}

moved {
  from = aws_subnet.private[0]
  to   = module.vpc.aws_subnet.private[0]
}

moved {
  from = aws_subnet.private[1]
  to   = module.vpc.aws_subnet.private[1]
}

moved {
  from = aws_route_table.public
  to   = module.vpc.aws_route_table.public
}

moved {
  from = aws_route.public_internet
  to   = module.vpc.aws_route.public_internet
}

moved {
  from = aws_route_table_association.public[0]
  to   = module.vpc.aws_route_table_association.public[0]
}

moved {
  from = aws_route_table_association.public[1]
  to   = module.vpc.aws_route_table_association.public[1]
}

moved {
  from = aws_route_table.private
  to   = module.vpc.aws_route_table.private
}

moved {
  from = aws_route_table_association.private[0]
  to   = module.vpc.aws_route_table_association.private[0]
}

moved {
  from = aws_route_table_association.private[1]
  to   = module.vpc.aws_route_table_association.private[1]
}
