output "vpc_id" {
  value = aws_vpc.main.id
}
output "alb_dns" {
  value = aws_lb.webpage_lb.dns_name #link to the website
}
