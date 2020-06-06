import { Component, AfterViewInit, ElementRef, ViewChild } from '@angular/core';

@Component({
  selector: 'app-georgefloyd',
  templateUrl: './georgefloyd.component.html',
  styleUrls: ['./georgefloyd.component.css']
})
export class GeorgefloydComponent implements AfterViewInit
{

  @ViewChild('countdown', {read: ElementRef, static:false}) countdownElementView: ElementRef;
  @ViewChild('ticker', {read: ElementRef, static:false}) tickerElementView: ElementRef;
  @ViewChild('display', {read: ElementRef, static:false}) displayElementView: ElementRef;
  private countdown = null;
  private ticker = null;
  private display = null;
  private duration: number = 0;
  private remainingDuration: number = 0;
  private message: string = "";
  private start = null;
  private running: boolean = false;
  private renderer = null;

  constructor() { }

  ngAfterViewInit(): void
  {
    const duration_in_milliseconds = 526000; // = 8.46 minutes
    const end_message = "RIP";
    this.init(duration_in_milliseconds, end_message);
    this.start_countdown();
  }

  private init(duration_in_milliseconds, end_message)
  {
    this.countdown = this.countdownElementView.nativeElement;
    this.ticker = this.tickerElementView.nativeElement;
    this.display = this.displayElementView.nativeElement;
    this.duration = duration_in_milliseconds;
    this.message = end_message;
    this.running = false;
  }

  private start_countdown(): void
  {
    this.start = null;
    this.running = true;
    this.remainingDuration = this.duration;
    this.display.textContent = this.msToTime(this.duration);
    this.renderer = requestAnimationFrame(this.render.bind(this));
  }

  private stop_countdown(): void
  {
    this.running = false;
    if (this.renderer)
    {
      cancelAnimationFrame(this.renderer);
    }
    this.display.textContent = this.message;
  }

  private render(now)
  {
    if (!this.start)
    {
      this.start = now;
    }
    const diff = now - this.start;
    const newDuration = Math.ceil((this.duration - diff));

    if (diff <= this.duration)
    {
			this.ticker.style.height = 100 - (diff/this.duration*100) + '%';

      if (newDuration != this.remainingDuration)
      {
        this.display.textContent = this.msToTime(newDuration);
				this.remainingDuration = newDuration;
      }

			this.renderer = requestAnimationFrame(this.render.bind(this));
    }
    else
    {
      this.ticker.style.height = '0%';
      this.stop_countdown();
    }
  }

  private msToTime(duration_in_milliseconds): string
  {
    const seconds = Math.floor((duration_in_milliseconds / 1000) % 60),
    minutes = Math.floor((duration_in_milliseconds / (1000 * 60)) % 60),
    hours = Math.floor((duration_in_milliseconds / (1000 * 60 * 60)) % 24);

    const enc_hours = (hours < 10) ? "0" + hours : hours;
    const enc_minutes = (minutes < 10) ? "0" + minutes : minutes;
    const enc_seconds = (seconds < 10) ? "0" + seconds : seconds;

    return enc_hours + ":" + enc_minutes + ":" + enc_seconds;
  }

}
