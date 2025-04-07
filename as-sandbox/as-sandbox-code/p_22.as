void main() {
    mock_ptr mock(2);
    mock_ptr@ p1 = @mock;
    p1.print().set_value(13).print().set_value(41).print();
}
